"""Exercise the real installer only in a disposable destination."""
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class InstallTest(unittest.TestCase):
    def run_install(self, target, *args, success=True):
        result = subprocess.run(
            ["bash", str(ROOT / "OSX/install.sh"), "--target-dir", str(target), *args],
            cwd="/tmp", capture_output=True, text=True, timeout=90,
        )
        if success:
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        else:
            self.assertNotEqual(result.returncode, 0, result.stdout)
        return result.stdout

    def test_preview_apply_idempotence_and_backup(self):
        with tempfile.TemporaryDirectory(prefix="dotfiles-test-") as work:
            target = Path(work) / "target with spaces"
            self.run_install(target)
            self.assertFalse(target.exists(), "Preview created the destination")
            self.run_install(target, "--apply")
            installed = target / ".zshrc"
            self.assertEqual(installed.read_bytes(), (ROOT / ".zshrc").read_bytes())
            self.assertEqual(installed.stat().st_mode & 0o777, 0o600)
            self.assertTrue((target / ".config/nvim/init.vim").is_file())
            output = self.run_install(target, "--apply")
            self.assertRegex(output, r"changed=0\s")
            installed.write_text("# previous user config\n")
            self.run_install(target, "--apply")
            backups = list(target.glob(".zshrc.*~"))
            self.assertEqual(len(backups), 1)
            self.assertEqual(backups[0].read_text(), "# previous user config\n")

    def test_symlink_directory_is_rejected(self):
        with tempfile.TemporaryDirectory(prefix="dotfiles-link-test-") as work:
            target = Path(work) / "target"
            target.mkdir()
            outside = Path(work) / "outside"
            outside.mkdir()
            (target / ".config").symlink_to(outside, target_is_directory=True)
            self.run_install(target, "--apply", success=False)
            self.assertEqual(list(outside.iterdir()), [])
            self.assertFalse((target / ".zshrc").exists())

    def test_invalid_arguments(self):
        self.run_install("/", success=False)
        self.run_install("//", success=False)
        self.run_install("/tmp/..", success=False)
        self.run_install("relative", success=False)
        self.run_install("/tmp/unused-dotfiles-target", "--unknown", success=False)

    def test_symlink_file_is_preserved(self):
        with tempfile.TemporaryDirectory(prefix="dotfiles-file-link-") as work:
            target = Path(work) / "target"
            target.mkdir()
            original = Path(work) / "original"
            original.write_text("# managed elsewhere\n")
            (target / ".zshrc").symlink_to(original)
            self.run_install(target, "--apply", success=False)
            self.assertTrue((target / ".zshrc").is_symlink())
            self.assertEqual(original.read_text(), "# managed elsewhere\n")

    def test_zsh_starts_without_optional_tools(self):
        with tempfile.TemporaryDirectory(prefix="dotfiles-zsh-") as work:
            stub = Path(work) / "brew"
            stub.write_text("#!/bin/sh\nprintf '%s\\n' /nonexistent-dotfiles-brew\n")
            stub.chmod(0o700)
            env = dict(os.environ, PATH=work + ":/usr/bin:/bin", ZDOTDIR=work,
                       XDG_CACHE_HOME=work, STARSHIP_CONFIG=str(ROOT / "OSX/files/starship.toml"))
            result = subprocess.run(
                ["zsh", "-dfi", "-c", 'source "$1"; print -r -- ready', "zsh", str(ROOT / ".zshrc")],
                env=env, capture_output=True, text=True, timeout=20,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stdout.strip(), "ready")
            self.assertEqual(result.stderr, "")

    def test_tmux_uses_an_isolated_server(self):
        with tempfile.TemporaryDirectory(prefix="dotfiles-tmux-") as work:
            socket = str(Path(work) / "tmux.sock")
            command = ["tmux", "-S", socket]
            try:
                result = subprocess.run(
                    command + ["-f", str(ROOT / ".tmux.conf"), "new-session", "-d",
                               "-s", "dotfiles-test", "/bin/sleep", "30"],
                    capture_output=True, text=True, timeout=10,
                )
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(result.stderr, "")
                prefix = subprocess.check_output(command + ["show-options", "-gv", "prefix"], text=True)
                self.assertEqual(prefix.strip(), "C-a")
            finally:
                subprocess.run(command + ["kill-server"], capture_output=True, timeout=10)

    def test_public_compatibility_copies_match(self):
        for filename in (".zshrc", ".tmux.conf", ".vimrc"):
            self.assertEqual((ROOT / filename).read_bytes(),
                             (ROOT / "OSX/files" / filename).read_bytes())


if __name__ == "__main__":
    unittest.main(verbosity=2)

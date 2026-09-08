#!/usr/bin/env bash
set -euo pipefail
dotfiles_script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
dotfiles_mode=--check
dotfiles_target="${HOME:?HOME must be set}"
dotfiles_packages=false
usage() {
  printf '%s\n' 'Usage: bash OSX/install.sh [--check | --apply | --packages] [--target-dir DIRECTORY]'
  printf '%s\n' 'Default: preview file changes only. --packages installs macOS dependencies only.'
}
while [[ $# -gt 0 ]]; do
  case "$1" in
    --check) dotfiles_mode=--check ;;
    --apply) dotfiles_mode=--apply ;;
    --packages) dotfiles_packages=true ;;
    --target-dir)
      [[ $# -ge 2 && -n "$2" && "$2" != --* ]] || { usage >&2; exit 2; }
      dotfiles_target="$2"; shift ;;
    --help|-h) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
  esac
  shift
done
if [[ "$dotfiles_packages" == true ]]; then
  [[ "$dotfiles_mode" != --apply && "$dotfiles_target" == "$HOME" ]] || { usage >&2; exit 2; }
  [[ "$(uname -s)" == Darwin ]] || { printf '%s\n' 'Install packages with your Linux package manager.' >&2; exit 1; }
  command -v brew >/dev/null || { printf '%s\n' 'Install Homebrew first: https://brew.sh' >&2; exit 1; }
  exec brew bundle install --no-upgrade --file="$dotfiles_script_dir/Brewfile"
fi
[[ "$dotfiles_target" == /* && "$dotfiles_target" != / ]] || { printf '%s\n' 'Target must be an absolute directory other than /.' >&2; exit 2; }
command -v ansible-playbook >/dev/null || { printf '%s\n' 'ansible-core is required. On macOS: bash OSX/install.sh --packages' >&2; exit 1; }
command -v python3 >/dev/null || { printf '%s\n' 'Python 3 is required.' >&2; exit 1; }
dotfiles_extra="$(python3 -c '
import json, os, sys
target = "/" + os.path.normpath(sys.argv[1]).lstrip("/")
if target == "/":
    sys.exit("The filesystem root is not a valid destination.")
print(json.dumps({"dotfiles_target_dir": target}))
' "$dotfiles_target")"
if [[ "$dotfiles_mode" == --check ]]; then
  set -- --check
else
  set --
fi
# Pas de --diff par défaut : les anciens fichiers peuvent contenir du privé.
exec ansible-playbook -i localhost, -c local "$dotfiles_script_dir/playbook.yml" \
  --extra-vars "$dotfiles_extra" "$@"

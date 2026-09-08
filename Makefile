.PHONY: verify test

verify:
	bash -n OSX/install.sh
	shellcheck OSX/install.sh
	zsh -n .zshrc
	luac -p OSX/files/.wezterm.lua
	vim -Nu .vimrc -i NONE -n -es -c 'qa!'
	nvim --headless -u init.vim -i NONE -n -c 'qa!'
	ansible-playbook -i localhost, --syntax-check OSX/playbook.yml
	git diff --check

test: verify
	python3 -m unittest discover -s tests -v

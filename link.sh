cd $(dirname $0)

rm-and-run () {
	if [[ -e $1 ]]; then
		rm -r $1
	fi

	$2 $1
}

replace-config () {
	# f is needed because symlinks to nowhere don't pass the -e test
	rm-and-run ~/.config/$1 "ln -fs $(realpath $2)"
}

# bash
ln -fs $(realpath bash/.bashrc) ~/

# git
ln -fs $(realpath git/.gitconfig) ~/
replace-config git git

# icons
rm-and-run ~/.config/gtk-3.0 "nix build ./nix#icons.gtk -o"
rm-and-run ~/.local/share/icons "nix build ./nix#icons.icons -o"

# i3
replace-config i3 i3/i3
replace-config i3status i3/i3status

# neovim
replace-config nvim neovim/config

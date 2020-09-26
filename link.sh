cd $(dirname $0)

function replaceDir {
	dir=~/.config/$2

	if [[ -h $dir ]]; then
		rm $dir
		ln -rs $1 $dir
	fi
}

# bash
ln -frs .bashrc ~/

# git
ln -frs git/.gitconfig ~/
replaceDir git git

# i3
replaceDir i3 i3

# neovim
replaceDir neovim/config nvim

# nix
ln -frs configuration.nix /etc/nixos/
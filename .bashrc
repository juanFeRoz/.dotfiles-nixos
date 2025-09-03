PATH="$PATH":"$HOME/.local/scripts/"
bind '"\C-f":"tmux-sessionizer\n"'

export EDITOR=neovim
export VISUAL=neovim

dev-templates() {
   nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#$1"
}

alias tmux=direnv-tmux

eval "$(direnv hook bash)"
alias config='git --git-dir=/home/juanfe/.cfg/ --work-tree=/home/juanfe'

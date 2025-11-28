if status is-interactive
and not set -q TMUX
    exec tmux 
end

neofetch
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
alias vv="nvim"
alias vim="nvim"

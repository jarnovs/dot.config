if status is-interactive
and not set -q TMUX
    exec tmux
end

alias l='ls'
alias la='ls -la'
zoxide init --cmd cd fish | source
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

alias vim="vv"
alias nvim="vv"
export EDITOR=vv

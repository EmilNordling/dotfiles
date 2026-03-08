# source ~/.zshrc
# ～☆～

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Vim
alias v="/opt/homebrew/bin/nvim"
alias vim=nvim
alias cu="container-use"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias zz="ls -A"
alias zl="ls"

# Git
alias g="git"
alias ga="git add"
alias gc="git commit -m"
alias gca="git commit -a -m"

# FZF
alias f="fzf"

export PATH="/opt/homebrew:$PATH"
export PATH="$PATH:$HOME/.cargo/bin"

# Go lang monkey patching
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
# Homebrew
export GOROOT="$(brew --prefix golang)/libexec"
# Manual install
# export GOROOT=/usr/local/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
. "/Users/emilnordling/.deno/env"

# bun completions
[ -s "/Users/emilnordling/.bun/_bun" ] && source "/Users/emilnordling/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Pomodoro
# To reset, run:
# unalias work 2>/dev/null;
work() {
    timer "${1:-25m}" && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Pluck
}

rest() {
    timer "${1:-5m}" && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over! Get back to work 😬'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Pluck
}

kp() {
    if [-z "$1"]; then
        echo "Usage: kp <port_number>"
        return 1
    fi

    # Find the PID running on the specified port
    local pid=$(lsof -ti:"$1")

    if [ -n "$pid" ]; then
        echo "Killing process $pid on port $1..."
        kill -9 $pid
    else
        echo "No process found on port $1."
    fi
}

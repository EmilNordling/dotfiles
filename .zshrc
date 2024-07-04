# ～☆～

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Vim
alias v="/opt/homebrew/bin/nvim"

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

# Go lang monkey patching
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
# Homebrew
export GOROOT="$(brew --prefix golang)/libexec"
# Manual install
# export GOROOT=/usr/local/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

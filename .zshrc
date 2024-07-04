eval "$(zoxide init zsh)"

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# ～☆～
alias zz="ls -A"
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

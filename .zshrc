# ～☆～

eval "$(zoxide init zsh)"
# eval "$(starship init zsh)"

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Vim
alias v="/opt/homebrew/bin/nvim"
alias vim=nvim

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

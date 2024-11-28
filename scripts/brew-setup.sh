#!/usr/bin/env bash

readonly TAG="[Homebrew]"

# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
    echo "$TAG Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

FORMULAE_LEAVES=(
    # https://formulae.brew.sh/formula/zsh
    # UNIX shell (command interpreter)
    zsh

    # https://formulae.brew.sh/cask/wezterm
    # GPU-accelerated cross-platform terminal emulator and multiplexer
    wezterm

    # https://formulae.brew.sh/formula/act#default
    # Run your GitHub Actions locally
    act

    # https://formulae.brew.sh/formula/fzf#default
    # Command-line fuzzy finder written in Go
    fzf

    # https://formulae.brew.sh/formula/git#default
    # Distributed revision control system, git lol
    git

    # https://formulae.brew.sh/formula/go#default
    # Open source programming language to build simple/reliable/efficient software
    go

    # https://formulae.brew.sh/formula/rust#default
    # Safe, concurrent, practical language
    rust

    # https://formulae.brew.sh/formula/starship#default
    # The cross-shell prompt for astronauts
    # starship

    # https://formulae.brew.sh/formula/mkcert#default
    # Simple tool to make locally trusted development certificates
    mkcert

    # https://formulae.brew.sh/formula/n#default
    # Node version management
    n

    # https://formulae.brew.sh/formula/neovim#default
    # Ambitious Vim-fork focused on extensibility and agility
    neovim

    # https://formulae.brew.sh/formula/pnpm#default
    # Fast, disk space efficient package manager
    pnpm

    # https://formulae.brew.sh/formula/zoxide#default
    # Shell extension to navigate your filesystem faster
    zoxide

    # https://formulae.brew.sh/formula/tmux#default
    # Terminal multiplexer
    tmux

    # https://github.com/tmux-plugins/tpm
    # Tmux Plugin Manager
    tpm

    # https://formulae.brew.sh/formula/stripe-cli#default
    # Command-line tool for Stripe
    stripe/stripe-cli/stripe
)

echo "$TAG Verifying Homebrew packages"

FORMULAE_TO_INSTALL=()
INSTALLED_LEAVES=$(brew list)

for l in "${FORMULAE_LEAVES[@]}"
do
    if ! echo $INSTALLED_LEAVES | grep -q $l; then
        FORMULAE_TO_INSTALL+=($l)
    fi
done

if [ ${#FORMULAE_TO_INSTALL[@]} -eq 0 ]; then
    echo "$TAG Everything seems to be in order"
    exit 0
fi

echo "$TAG Installing missing packages..."
brew install ${FORMULAE_TO_INSTALL[@]}

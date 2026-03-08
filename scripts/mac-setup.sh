#!/usr/bin/env bash

readonly TAG="[MacOS Setup]"

echo "$TAG Starting new MacOS setup"

/bin/bash ./scripts/symlink-repo.sh

echo "$TAG MacOS setup complete!"

defaults write -g InitialKeyRepeat -int 12
defaults write -g KeyRepeat -int 2

defaults write -g ApplePressAndHoldEnabled -bool false

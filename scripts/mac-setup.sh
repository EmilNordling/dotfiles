#!/usr/bin/env bash

readonly TAG="[MacOS Setup]"

echo "$TAG Starting new MacOS setup"

/bin/bash ./scripts/brew-setup.sh
/bin/bash ./scripts/symlink-repo.sh

echo "$TAG MacOS setup complete!"

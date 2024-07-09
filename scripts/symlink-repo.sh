#!/usr/bin/env bash

readonly TAG="[Symlink]"
readonly SELF_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
readonly PATHS=(
    ".tmux.conf $SELF_DIR/../ $HOME/"
    ".wezterm.lua $SELF_DIR/../ $HOME/"
    ".zshrc $SELF_DIR/../ $HOME/"
    ".config/zed/settings.json $SELF_DIR/../ $HOME/"
)

is_symlink() {
  local path_to_check="$1"

  if [ -L "$path_to_check" ]; then
    return 0  # true
  else
    return 1  # false
  fi
}

create_symlink() {
  local target_path="$1"
  local link_path="$2"

  ln -s "$target_path" "$link_path"
  echo "$TAG Created symlink: $link_path -> $target_path"
}

# Loop through each path and check if it is a symlink
for path_pair in "${PATHS[@]}"; do
    f1=$(echo "$path_pair" | cut -d ' ' -f 1)
    f2=$(echo "$path_pair" | cut -d ' ' -f 2)
    f3=$(echo "$path_pair" | cut -d ' ' -f 3)

    target="$f2$f1"
    link="$f3$f1"

    if is_symlink "$link"; then
        echo "$TAG $f1 is already a symbolic link."
    else
       create_symlink "$target" "$link"
    fi
done

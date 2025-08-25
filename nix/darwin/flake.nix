# First time, run:
# nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/source/dotfiles/nix/darwin#nord

# To update the configuration, run:
# darwin-rebuild switch --flake ~/source/dotfiles/nix/darwin#nord

{
  description = "General Purpose Configuration for macOS and NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nix-homebrew,
      nixpkgs,
    }:
    let
      configuration =
        { pkgs, config, ... }:
        {
          nixpkgs.config.allowUnfree = true;

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pkgs.gh # Github cli
            pkgs.mkalias # Create aliases for executables
            pkgs.neovim # vim
            pkgs.tmux # Terminal multiplexer
            pkgs.nixfmt-rfc-style # The official formatter for Nix code
            pkgs.zsh # UNIX shell (command interpreter)
            pkgs.act # Run your GitHub Actions locally
            pkgs.fzf # Command-line fuzzy finder written in Go
            pkgs.git # Distributed revision control system, git lol
            # pkgs.starship # The cross-shell prompt for astronauts
            pkgs.mkcert # Simple tool to make locally trusted development certificates
            pkgs.zoxide # Shell extension to navigate your filesystem faster
            pkgs.obsidian # Research note-taking app
            pkgs.bun # Node but not Node
            pkgs.sqlc # Generate repo from SQL schema
            # pkgs.ghostty # Terminal emulator / multiplexer (instead of Wezterm?!)
            pkgs.wezterm
          ];

          homebrew = {
            enable = true;
            casks = [
              # Whale
              # "docker"

              # https://formulae.brew.sh/cask/visual-studio-code#default
              # SQL client (another one)
              "azure-data-studio"

              # https://formulae.brew.sh/cask/beekeeper-studio#default
              # SQL client
              "beekeeper-studio"

              # https://formulae.brew.sh/cask/spotify#default
              # Music streaming
              "spotify"

              # https://formulae.brew.sh/cask/zed#default
              # Editor
              "zed"

              # https://formulae.brew.sh/cask/wezterm#default
              # Terminal emulator
              # "wezterm@nightly"

              # https://formulae.brew.sh/cask/fork#default
              # Git client
              "fork"

              # https://formulae.brew.sh/cask/slack#default
              # Team communication and collaboration software
              "slack"

              # https://formulae.brew.sh/cask/linear-linear#default
              # Issue tracking and project management
              "linear-linear"

              # https://formulae.brew.sh/cask/figma#default
              # Interface design tool
              "figma"

              # https://formulae.brew.sh/cask/screen-studio#default
              # Screen recorder and editor
              "screen-studio"

              # https://formulae.brew.sh/cask/google-chrome#default
              # Web browser
              "google-chrome"

              # https://formulae.brew.sh/cask/microsoft-edge#default
              # Web browser
              "microsoft-edge"

              # https://formulae.brew.sh/cask/firefox#default
              # Web browser
              "firefox"

              # https://formulae.brew.sh/cask/zen-browser#default
              # Web browser
              #"zen-browser"

              # https://formulae.brew.sh/cask/orbstack#default
              # Fast, lightweight, simple Docker Desktop alternative
              "orbstack"

              # https://formulae.brew.sh/cask/1password#default
              # Password manager
              "1password"
            ];
            taps = [
              # https://github.com/dagger/container-use
              # Container resource usage monitoring tool
              #"dagger/tap/container-use"
            ];
            brews = [
              # https://formulae.brew.sh/formula/ffmpeg#default
              # Video encoding
              "ffmpeg"

              # https://formulae.brew.sh/formula/stow#default
              # Symlink farm manager
              "stow"

              # https://formulae.brew.sh/formula/jq#default
              # Lightweight and flexible command-line JSON processor
              "jq"

              # https://formulae.brew.sh/formula/doppler#default
              # CLI for interacting with Doppler secrets manager
              "dopplerhq/cli/doppler"

              # https://formulae.brew.sh/formula/fd#default
              # Simple, fast and user-friendly alternative to find
              "fd"

              # https://formulae.brew.sh/formula/ripgrep#default
              # Search tool like grep and The Silver Searcher
              "ripgrep"

              # Database migrations
              "golang-migrate"

              # https://formulae.brew.sh/formula/go#default
              # Go lang
              "go"

              # https://formulae.brew.sh/formula/rust#default
              # Rust lang
              "rust"

              # https://formulae.brew.sh/formula/n#default
              # Node version management
              "n"

              # https://formulae.brew.sh/formula/pnpm#default
              # Fast, disk space efficient package manager
              "pnpm"

              # https://github.com/tmux-plugins/tpm
              # Tmux Plugin Manager
              "tpm"

              # https://formulae.brew.sh/formula/starship#default
              # The cross-shell prompt for astronauts
              "starship"

              ##########################

              # https://formulae.brew.sh/formula/vercel-cli#default
              # Command-line interface for Vercel
              "vercel-cli"

              # https://formulae.brew.sh/formula/commitizen#default
              # Defines a standard way of committing rules and communicating it
              "commitizen"

              # https://formulae.brew.sh/formula/awscli#default
              # Universal Command Line Interface for Amazon Web Services
              "awscli"

              # https://formulae.brew.sh/formula/railway#default
              # Railway CLI for deploying applications
              "railway"
            ];
            onActivation.cleanup = "zap";
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;
          };

          system.activationScripts.applications.text =
            let
              env = pkgs.buildEnv {
                name = "system-applications";
                paths = config.environment.systemPackages;
                pathsToLink = "/Applications";
              };
            in
            pkgs.lib.mkForce ''
              # Set up applications.
              echo "setting up /Applications..." >&2
              rm -rf /Applications/Nix\ Apps
              mkdir -p /Applications/Nix\ Apps
              find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
              while read -r src; do
                  app_name=$(basename "$src")
                  echo "copying $src" >&2
                  ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
              done
            '';

          system.defaults = {
            dock.autohide = true;
            dock.largesize = 58;
            dock.tilesize = 48;
            dock.magnification = true;
            dock.autohide-delay = null;
            dock.minimize-to-application = false;
            dock.show-recents = false;
            dock.mineffect = "scale";
            dock.persistent-apps = [
              "/Applications/Safari.app"
              "/Applications/Zed.app"
              "/Applications/Nix Apps/WezTerm.app"
              "/Applications/Fork.app"
              "/Applications/Figma.app"
              "/Applications/Linear.app"
              "/Applications/Slack.app"
              "/System/Applications/Mail.app"
              "/System/Applications/Calendar.app"
              "/Applications/Firefox.app"
              "/Applications/Microsoft Edge.app"
              "/Applications/Google Chrome.app"
            ];
            finder.FXPreferredViewStyle = "clmv";
            finder.AppleShowAllFiles = true;
            finder.AppleShowAllExtensions = true;
            loginwindow.GuestEnabled = false;
            NSGlobalDomain.AppleICUForce24HourTime = true;
            NSGlobalDomain.AppleInterfaceStyle = "Dark";
            NSGlobalDomain.KeyRepeat = 2;
          };

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."nord" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "emilnordling";
            };
          }
        ];
      };
    };
}

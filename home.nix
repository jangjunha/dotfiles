{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    zsh
    starship
    git
    delta
    lsd
    fd
    bat
    fzf
    ripgrep
    neovim

    uv
    pnpm
    rustup
    opentofu
    terraform-ls
    container
    gh
    jq
    httpie
    pre-commit
    awscli2
    google-cloud-sdk
    nixfmt-rfc-style
  ];

  home.file = {
    ".config/nvim" = {
      source = dotfiles/nvim;
      recursive = true;
    };
    ".config/alacritty" = {
      source = dotfiles/alacritty;
      recursive = true;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/junha/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    LANG = "en_US.UTF-8";
    LESS = "-FRX";
    FZF_DEFAULT_COMMAND = "fd --type f --strip-cwd-prefix";
    FZF_CTRL_T_COMMAND = "fd --type f --strip-cwd-prefix";
  };
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "jangjunha";
        email = "hi@jangjunha.me";
      };
      alias = {
        sw = "switch";
        co = "checkout";
        ci = "commit";
        st = "status";
        df = "diff";
        dc = "diff --cached";
      };
      init = {
        defaultBranch = "main";
      };
      delta = {
        enable = true;
      };
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };
    ignores = [
      "*~"
      ".DS_Store"
      "**/.claude/settings.local.json"
    ];
  };

  programs.lsd = {
    enable = true;
    settings = {
      blocks = [
        "permission"
        "user"
        "group"
        "size"
        "date"
        "git"
        "name"
      ];
      date = "+%Y-%m-%d %H:%M:%S";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      g = "git";
      bp = "bat -pp";
      vim = "nvim";
    };

    initContent = ''
      # Option + backspace
      bindkey '^[^?' backward-kill-word
      bindkey '^W' backward-kill-word

      # Option + Delete
      bindkey '^[[3;3~' kill-word
      bindkey '^[d' kill-word

      # Option + Arrow
      bindkey '^[^[[D' backward-word
      bindkey '^[^[[C' forward-word
      bindkey '^[[1;3D' backward-word
      bindkey '^[[1;3C' forward-word

      # Colors
      autoload colors; colors;

      # Completions
      autoload -Uz compinit bashcompinit
      compinit
      bashcompinit

      source ${dotfiles/zsh/fzf-git.sh}

      # iTerm2 integration
      test -e "''${HOME}/.iterm2_shell_integration.zsh" && source "''${HOME}/.iterm2_shell_integration.zsh"

      # Homebrew
      test -e /opt/homebrew/bin/brew && eval "$(/opt/homebrew/bin/brew shellenv)"
    '';

    history = {
      size = 10000;
      save = 10000;
      share = true;
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      username = {
        format = "[$user]($style) ";
        show_always = true;
      };
      gcloud.disabled = true;
    };
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      userSettings = {
        "telemetry.telemetryLevel" = "off";
        "editor.formatOnSave" = true;
        "workbench.sideBar.location" = "right";
        "editor.rulers" = [
          80
          120
        ];
      };
      extensions = with pkgs.vscode-extensions; [
        ms-azuretools.vscode-containers
        github.vscode-github-actions
        editorconfig.editorconfig
        ms-python.python
        charliermarsh.ruff
        biomejs.biome
        rust-lang.rust-analyzer
        hashicorp.terraform
        jnoortheen.nix-ide
      ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

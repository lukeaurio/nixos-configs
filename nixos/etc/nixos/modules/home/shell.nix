{ ... }:
{
  flake.modules.homeManager.shell = {
    # MyNixOS documents initContent as content added to .zshrc:
    # https://mynixos.com/home-manager/option/programs.zsh.initContent
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        update = "sudo nixos-rebuild switch";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        ls = "tree -L 1";
        l = "ls -lh";
        la = "ls -lAh";
        ll = "ls -lah";
        lg = "lazygit";
        snv = "sudo nvim";
        nixgit = "git --git-dir=$HOME/.nixos-config/ --work-tree=$HOME";
        lazynix = "lazygit --git-dir=$HOME/.nixos-config/ --work-tree=$HOME";
        rustdoc = "rustup doc --book";
        ghostcuts = "ghostty +list-keybinds --default";
        man = "tldr";
        cat = "bat";
        nixclean = "nix-env --delete-generations 10d && nix-store --gc";
        flakeup = "sudo nix flake update && sudo nixos-rebuild switch";
      };
      initContent = ''
        source $HOME/shell_scripts/zsh_start.sh
        if [ "$VSCODE_INJECTION" = "1" ]; then
          export EDITOR="code --wait"
        fi
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "terraform"
          "gcloud"
          "zoxide"
          "dotenv"
          "poetry"
          "tailscale"
          "rust"
          "tmux"
        ];
        theme = "robbyrussell";
      };
      history.size = 10000;
    };

    programs.tmux = {
      enable = true;

      extraConfig = ''
        # Improve colors
        set -g default-terminal "screen-256color"

        # Set prefix to Ctrl-a
        set -g prefix C-a
        unbind C-b
        bind C-a send-prefix

        # Easy config reload
        bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"

        # Mouse support
        set -g mouse on

        # Start windows and panes at 1, not 0
        set -g base-index 1
        setw -g pane-base-index 1
      '';
    };

    programs.keychain = {
      enable = true;
      keys = [ "id_ed25519" ];
      extraFlags = [
        "--quiet"
        "--ssh-allow-forwarded"
      ];
      enableZshIntegration = true;
    };
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.lazygit = {
      enable = true;
      enableZshIntegration = true;
      settings.gui.skipDiscardChangeWarning = true;
    };
    programs.git = {
      enable = true;
      lfs = {
        enable = true;
        skipSmudge = true;
      };
      settings = {
        user = {
          email = "lukeaurio@proton.me";
          name = "Lukas Aurio";
        };
        core = {
          editor = "nvim";
          longpaths = "true";
        };
        pull.rebase = "false";
        push.autosetupremote = "true";
      };
    };
  };
}

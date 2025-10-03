{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "willberto";
  home.homeDirectory = "/home/willberto";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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
  #  /etc/profiles/per-user/willberto/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
       ghostcuts = "ghostty +list-keybinds --default";
       man = "tldr";
       cat = "bat";
       nixclean = "nix-env --delete-generations 10d && nix-store --gc";
     };
     initContent = ''
     source $HOME/shell_scripts/zsh_start.sh 
     if [ "$VSCODE_INJECTION" = "1" ]; then
       export EDITOR="code --wait" # or 'code-insiders' if you're using VS Code Insiders
     fi
     ''; #https://mynixos.com/home-manager/option/programs.zsh.initContent
     oh-my-zsh = { # "ohMyZsh" without Home Manager
       enable = true;
       plugins = [ 
         "git"
         "terraform" 
         "gcloud" 
         "zoxide" 
         "dotenv" 
         "poetry" 
         "tailscale" 
       ];
       theme = "robbyrussell";
     };
     history.size = 10000;
  };

  programs.keychain = {
    enable = true;
    #agents = [ "ssh" ];
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

  programs.git = {
    enable = true;
    userName  = "Lukas Aurio";
    userEmail = "lukeaurio@proton.me";
  };

  programs.oh-my-posh = {
     enable = true;
     enableZshIntegration = true;
     settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (''
    {
      "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
      "blocks": [
        {
          "alignment": "left",
          "segments": [
            {
              "background": "#18354c",
              "foreground": "#ffc107",
              "leading_diamond": "\ue0b6",
              "properties": {
                "style": "fish",
                "full_length_dirs": 1,
                "dir_legth": 3
              },
              "style": "diamond",
              "template": " \ue5ff {{ .Path }} ",
              "trailing_diamond": "\ue0b0",
              "type": "path"
            },
            {
              "background": "#18354c",
              "foreground": "#ffc107",
              "powerline_symbol": "\ue0b0",
              "properties": {
                "fetch_upstream_icon": true
              },
              "style": "powerline",
              "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{ if gt .StashCount 0 }} \ueb4b {{ .StashCount }}{{ end }} ",
              "type": "git"
            },
            {
              "background": "#ffc107",
              "foreground": "#18354c",
              "powerline_symbol": "\ue0b0",
              "style": "powerline",
              "template": " \ue235 {{ if .Error }}{{ .Error }}{{ else }}{{ if .Venv }}{{ .Venv }} {{ end }}{{ .Full }}{{ end }} ",
              "type": "python"
            },
            {
              "background": "#ffc107",
              "foreground": "#18354c",
              "powerline_symbol": "\ue0b0",
              "style": "powerline",
              "template": " \uf0e7 ",
              "type": "root"
            }
          ],
          "type": "prompt"
        }
      ],
      "final_space": true,
      "version": 3
    }
  ''));
  };

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      #background = "000000";
      background-opacity = "0.6";
      #custom-shader = "$HOME/Submodules/ghostty-shaders/bettercrt.glsl";
      #custom-shader-animation = "always";
      cursor-style = "block";
      font-family = "GohuFont uni14 Nerd Font";
    };
  };

  programs.nixcord = {
     enable  = true; 
     vesktop.enable  = true;
  };

  programs.vscode = {
    enable = true; 
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        ms-python.python
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
        platformio.platformio-vscode-ide
        golang.go
        budparr.language-hugo-vscode
        github.copilot
        github.copilot-chat
        github.vscode-github-actions
        mhutchie.git-graph
        waderyan.gitblame
    ]; # https://github.com/Arut0ria/nixos-desktop-config/blob/main/homeManagerModules/programs/vscode.nix for reference
  };

  programs.floorp = {
    enable = true;
  };

  stylix = {
    enable = true;
    targets = {
      vscode = {
        enable = true;
        profileNames = [
          "default"
          "Dark Modern"
        ];
      };
    };
  };
}

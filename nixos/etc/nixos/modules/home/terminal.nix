{ ... }:
{
  flake.modules.homeManager.terminal = {
    programs.tmux = {
      enable = true;
      extraConfig = ''
        set -g default-terminal "screen-256color"
        set -g prefix C-a
        unbind C-b
        bind C-a send-prefix
        bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"
        set -g mouse on
        set -g base-index 1
        setw -g pane-base-index 1
      '';
    };

    programs.fastfetch = {
      enable = true;
      settings = {
        display.separator = " ";
        width = 31;
        modules = [
          {
            key = "╭───────────╮";
            type = "custom";
          }
          {
            key = "│  user    │";
            type = "title";
            format = "{user-name}";
          }
          {
            key = "│ 󰇅 hname   │";
            type = "title";
            format = "{host-name}";
          }
          {
            key = "│ 󰅐 uptime  │";
            type = "uptime";
          }
          {
            key = "│  distro  │";
            type = "os";
          }
          {
            key = "│  kernel  │";
            type = "kernel";
          }
          {
            key = "│  wm      │";
            type = "wm";
          }
          {
            key = "│  term    │";
            type = "terminal";
          }
          {
            key = "│  shell   │";
            type = "shell";
          }
          {
            key = "│ 󰍛 cpu     │";
            type = "cpu";
            showPerCoreCount = true;
          }
          {
            key = "│ 󰉉 disk    │";
            type = "disk";
            folders = "/";
          }
          {
            key = "│  memory  │";
            type = "memory";
          }
          {
            key = "├───────────┤";
            type = "custom";
          }
          {
            key = "│ PC        │";
            type = "host";
            format = "{5} {1} ({2})";
          }
          {
            key = "│ ├ 󰢮 gpu   │";
            type = "gpu";
            format = "{1} {2} @ {12}";
          }
          {
            key = "│ ├ 󰓡 swap  │";
            type = "swap";
          }
          {
            key = "│ ├  disp  │";
            type = "monitor";
            format = "{1} px @ {2} Hz - {3} mm ({4} inches; {5} pp)";
          }
          {
            key = "│ └  dtime │";
            type = "command";
            text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
          }
          {
            key = "│  colors  │";
            type = "colors";
            symbol = "circle";
          }
          {
            key = "╰───────────╯";
            type = "custom";
          }
        ];
      };
    };

    programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      settings = builtins.fromJSON (
        builtins.unsafeDiscardStringContext ''
          {
            "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
            "blocks": [{
              "alignment": "left",
              "segments": [
                {"background":"#18354c","foreground":"#ffc107","leading_diamond":"\ue0b6","properties":{"style":"fish","full_length_dirs":1,"dir_legth":3},"style":"diamond","template":" \ue5ff {{ .Path }} ","trailing_diamond":"\ue0b0","type":"path"},
                {"background":"#18354c","foreground":"#ffc107","powerline_symbol":"\ue0b0","properties":{"fetch_upstream_icon":true},"style":"powerline","template":" {{ .UpstreamIcon }}{{ .HEAD }}{{ if gt .StashCount 0 }} \ueb4b {{ .StashCount }}{{ end }} ","type":"git"},
                {"background":"#ffc107","foreground":"#18354c","powerline_symbol":"\ue0b0","style":"powerline","template":" \ue235 {{ if .Error }}{{ .Error }}{{ else }}{{ if .Venv }}{{ .Venv }} {{ end }} ","type":"python"},
                {"background":"#ffc107","foreground":"#18354c","powerline_symbol":"\ue0b0","style":"powerline","template":" \uf0e7 ","type":"root"}
              ],
              "type": "prompt"
            }],
            "final_space": true,
            "version": 3
          }
        ''
      );
    };

    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        cursor-style = "block";
        term = "xterm-256color";
      };
    };
  };
}

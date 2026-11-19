{ ... }:
{
  flake.modules.homeManager.terminal =
    { config, pkgs, ... }:
    let
      colors = config.lib.stylix.colors.withHashtag;
    in
    {
      programs = {
        tmux = {
          enable = true;
          terminal = "tmux-256color";
          prefix = "C-a";
          baseIndex = 1;
          mouse = true;
          keyMode = "vi";
          customPaneNavigationAndResize = true;
          focusEvents = true;
          historyLimit = 50000;
          plugins = [
            pkgs.tmuxPlugins.resurrect
            {
              plugin = pkgs.tmuxPlugins.continuum;
              extraConfig = ''
                set -g @continuum-save-interval 15
                set -g @continuum-restore on

                # Keep Stylix colours; show a reminder instead of adding a theme plugin.
                # Home Manager loads this before Continuum, preserving its autosave hook.
                set -g status-left-length 20
                set -g status-left " #S "
                set -g status-right-length 55
                set -g status-right "#{?client_prefix,PREFIX | ,}Ctrl-a ? help | %H:%M "
              '';
            }
          ];
          extraConfig = ''
            # BEGINNER GUIDE
            # A session holds windows (tabs); each window holds panes (split terminals).
            # Start or reconnect: tmux new -As work. List sessions: tmux ls.
            # Press Ctrl-a, RELEASE both keys, then press a command below.
            # Ctrl-b also works, so standard tmux tutorials still apply.
            #   ?          Show key bindings; q closes help.
            #   c          New window in this directory; , renames the window.
            #   n / p      Next / previous window; 1..9 selects its number.
            #   | / -      Split side by side / top and bottom.
            #   Arrow keys Move between panes; h/j/k/l also work.
            #   H/J/K/L    Resize panes; z toggles zoom; Space cycles layouts.
            #   w / s      Choose a window / session from a list.
            #   d          Detach safely; commands keep running until shutdown.
            #   x          Close a pane after confirmation; this stops its programs.
            #   [          Scroll/copy mode: arrows move, v selects, y copies.
            #   Escape / q Leave copy mode; ] pastes the copied text inside tmux.
            #   Ctrl-s     Save the session layout now; Ctrl-r restores the last snapshot.
            # Mouse: click panes/windows, drag borders to resize, scroll for history.
            # Clipboard sync also works when the outer terminal supports OSC 52.
            # Ctrl-a Ctrl-a sends a literal Ctrl-a to the program inside tmux.
            # Edit this Nix module, rebuild, then Ctrl-a r reloads the generated config.
            # Layouts autosave every 15 minutes and restore when a new tmux server starts.
            # Running jobs and unsaved editor changes do not survive a reboot.
            #
            # Ideas: https://github.com/gpakosz/.tmux
            # https://github.com/tmux-plugins/tmux-sensible
            # https://github.com/thoughtbot/dotfiles/blob/main/tmux.conf

            set -g prefix2 C-b
            bind -N "Send Ctrl-b through to the application" C-b send-prefix -2
            set -g renumber-windows on
            set -g display-time 4000
            set -g display-panes-time 2000
            set -g status-keys emacs
            set -g set-clipboard external
            # Ghostty is configured below to identify itself as xterm-256color.
            set -as terminal-features ",xterm-256color:RGB"

            bind -N "New window in the current directory" c new-window -c "#{pane_current_path}"
            bind -N "Split side by side in the current directory" | split-window -h -c "#{pane_current_path}"
            bind -N "Split top and bottom in the current directory" - split-window -v -c "#{pane_current_path}"
            bind -N "Split side by side in the current directory" % split-window -h -c "#{pane_current_path}"
            bind -N "Split top and bottom in the current directory" '"' split-window -v -c "#{pane_current_path}"
            bind -N "Reload the Home Manager tmux configuration" r source-file "${config.xdg.configHome}/tmux/tmux.conf" \; display-message "Config reloaded!"
            bind -T copy-mode-vi v send-keys -X begin-selection
            bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
            bind -T copy-mode-vi Escape send-keys -X cancel

          '';
        };

        fastfetch = {
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

        oh-my-posh = {
          enable = true;
          enableZshIntegration = true;
          settings = builtins.fromJSON (
            builtins.unsafeDiscardStringContext ''
              {
                "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
                "blocks": [{
                  "alignment": "left",
                  "segments": [
                    {"background":"${colors.base01}","foreground":"${colors.base0D}","leading_diamond":"\ue0b6","properties":{"style":"fish","full_length_dirs":1,"dir_length":3},"style":"diamond","template":" \ue5ff {{ .Path }} ","trailing_diamond":"\ue0b0","type":"path"},
                    {"background":"${colors.base01}","foreground":"${colors.base0D}","powerline_symbol":"\ue0b0","properties":{"fetch_upstream_icon":true},"style":"powerline","template":" {{ .UpstreamIcon }}{{ .HEAD }}{{ if gt .StashCount 0 }} \ueb4b {{ .StashCount }}{{ end }} ","type":"git"},
                    {"background":"${colors.base0D}","foreground":"${colors.base05}","powerline_symbol":"\ue0b0","properties":{"parse_kubeconfig":true},"style":"powerline","template":" \u2388 {{ .Context }} :: {{ if .Namespace }}{{ .Namespace }}{{ else }}default{{ end }} ","type":"kubectl"},
                    {"background":"${colors.base0E}","foreground":"${colors.base05}","powerline_symbol":"\ue0b0","properties":{"command":"terraform"},"style":"powerline","template":" \ue69a TF {{ .WorkspaceName }} ","type":"terraform"},
                    {"background":"${colors.base0E}","foreground":"${colors.base05}","powerline_symbol":"\ue0b0","properties":{"command":"tofu"},"style":"powerline","template":" \ue69a Tofu {{ .WorkspaceName }} ","type":"terraform"},
                    {"background":"${colors.base0A}","foreground":"${colors.base05}","powerline_symbol":"\ue0b0","properties":{"display_mode":"context"},"style":"powerline","template":" \ue235 {{ if .Error }}{{ .Error }}{{ else }}{{ if .Venv }}{{ .Venv }} {{ end }}{{ .Full }}{{ end }} ","type":"python"},
                    {"background":"${colors.base08}","foreground":"${colors.base0D}","powerline_symbol":"\ue0b0","style":"powerline","template":" \uf0e7 ","type":"root"}
                  ],
                  "type": "prompt"
                }],
                "final_space": true,
                "version": 3
              }
            ''
          );
        };

        ghostty = {
          enable = true;
          enableZshIntegration = true;
          settings = {
            cursor-style = "block";
            term = "xterm-256color";
          };
        };
      };
    };
}

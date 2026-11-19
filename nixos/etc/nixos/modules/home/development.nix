{ ... }:
{
  flake.modules.homeManager.development =
    {
      pkgs,
      ...
    }:
    {
      programs.lazyvim = {
        enable = true;
        pluginSource = "nixpkgs";
        ignoreBuildNotifications = false;
        extras = {
          lang = {
            docker.enable = true;
            go.enable = true;
            helm.enable = true;
            markdown.enable = true;
            nix.enable = true;
            python.enable = true;
            terraform.enable = true;
            yaml.enable = true;
          };
          editor = {
            telescope.enable = true;
          };
          formatting.black.enable = true;
        };
        extraPackages = with pkgs; [
          nixd
          pyright
          black
          alejandra
          statix
          lua-language-server
          stylua
          gopls
          gofumpt
          gotools
          golangci-lint
          ruff
          helm-ls
          terraform-ls
          yaml-language-server
          marksman
          markdownlint-cli2
          markdown-toc
          prettier
          dockerfile-language-server
          docker-compose-language-service
          hadolint
        ];
        plugins.trouble = ''
          return {
            -- shortcut: eager-load Trouble until lazyvim-nix PR #119 fixes dev-path module loading.
            { "folke/trouble.nvim", lazy = false },
          }
        '';
        plugins.nix-tools = ''
          return {
            {
              "neovim/nvim-lspconfig",
              opts = {
                servers = {
                  nil_ls = { enabled = false },
                  nixd = {
                    settings = {
                      nixd = {
                        formatting = { command = { "alejandra" } },
                      },
                    },
                  },
                },
              },
            },
            {
              "stevearc/conform.nvim",
              opts = function(_, opts)
                opts.formatters_by_ft.nix = { "alejandra" }
              end,
            },
          }
        '';
        plugins.stylix = ''
          return {
            {
              "LazyVim/LazyVim",
              opts = {
                -- Stylix applies mini.base16 before LazyVim starts; keep that theme.
                colorscheme = function() end,
              },
            },
          }
        '';
      };

      programs.vscode = {
        enable = true;
        mutableExtensionsDir = false;
        profiles.default = {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
          userSettings = {
            "git.autofetch" = true;
            "git.mergeEditor" = true;
            "editor.formatOnSave" = true;
            "editor.formatOnPaste" = true;
            "editor.minimap.enabled" = true;
            "editor.stickyScroll.enabled" = true;
            "extensions.autoUpdate" = false;
            "update.mode" = "none";
            "files.autoSave" = "onFocusChange";
            "[markdown]"."editor.quickSuggestions" = true;
            "markdown.editor.pasteUrlAsFormattedLink.enabled" = "smart";
            "markdown.validate.enabled" = true;
          };
          extensions = with pkgs.vscode-marketplace-release; [
            bbenoist.nix
            ms-python.python
            ms-python.vscode-pylance
            ms-python.pylint
            ms-python.debugpy
            golang.go
            hashicorp.terraform
            ms-azuretools.vscode-docker
            ms-vscode-remote.remote-ssh
            platformio.platformio-ide
            budparr.language-hugo-vscode
            rust-lang.rust-analyzer
            ms-vscode.cpptools
            ms-vscode.cpptools-extension-pack
            sst-dev.opencode
            github.vscode-github-actions
            mhutchie.git-graph
            waderyan.gitblame
          ];
        };
      };
    };
}

{ inputs, ... }:
{
  flake.modules.homeManager.ai = {
    xdg.configFile = {
      "opencode/commands" = {
        source = "${inputs.caveman}/src/plugins/opencode/commands";
        recursive = true;
      };
      "opencode/skills/drawio" = {
        source = "${inputs.drawio-mcp}/plugins/claude-code/skills/drawio";
        recursive = true;
      };
    };
    programs = {
      mcp = {
        enable = true;
        servers = {
          n8n = {
            url = "https://n8n.lukeaurio.net/mcp-server/http";
          };
          home-assistant = {
            url = "https://ha.lukeaurio.net/api/mcp";
          };
          terraform = {
            command = "docker";
            args = [
              "run"
              "-i"
              "--rm"
              "hashicorp/terraform-mcp-server:latest"
            ];
          };
          kubernetes = {
            command = "npx";
            args = [
              "-y"
              "kubernetes-mcp-server@latest"
            ];
          };
          playwright = {
            command = "npx";
            args = [
              "-y"
              "@playwright/mcp@latest"
            ];
          };
          sequential-thinking = {
            command = "npx";
            args = [
              "-y"
              "@modelcontextprotocol/server-sequential-thinking@latest"
            ];
          };
        };
      };
      opencode = {
        enable = true;
        enableMcpIntegration = true;
        context = ''
          - only use git commands when explicitly asked to
          - never run infrastructure commands without confirmation (tofu or terraform apply, nix upgrades other than updating flake locks and evaluation)
          - if building variables, always make sure to write input validation and error handling
        '';
        settings = {
          autoshare = false;
          autoupdate = true;
          plugins = [
            "@tarquinen/opencode-dcp@latest"
            "@dietrichgebert/ponytail"
            "${inputs.caveman}/src/plugins/opencode"
          ];
          #  "provider": {
          # "lmstudio": {
          #   "npm": "@ai-sdk/openai-compatible",
          #   "name": "LM Studio (local)",
          #   "options": {
          #   "baseURL": "http://127.0.0.1:1234/v1"
          #   }
          # }
          # }
        };
      };
    };
  };
}

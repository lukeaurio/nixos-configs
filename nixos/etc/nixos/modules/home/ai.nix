{ ... }:
{
  flake.modules.homeManager.ai = {
    programs.mcp = {
      enable = true;
      servers = {
        n8n = {
          url = "http://192.168.1.74:5678/mcp-server/http";
        };
        home-assistant = {
          url = "https://ha.lukeaurio.net/api/mcp";
        };
      };
    };
    programs.opencode = {
      enable = true;
      enableMcpIntegration = true;
      settings = {
        autoshare = false;
        autoupdate = true;
        plugin = [
          "opencode-skills"
          ''\@tarquinen/opencode-dcp\@latest''
          "opencode-lmstudio"
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
    programs.codex = {
      enable = true;
      enableMcpIntegration = true;
      context = ''
        - only use git commands when explicitly asked to
        - never run infrastructure commands without confirmation (tofu or terraform apply)
        - if building variables, always make sure to write input validation and error handling
      '';
    };
  };
}

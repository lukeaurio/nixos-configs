{ ... }:
{
  flake.modules.homeManager.ai = {
    programs.opencode = {
      enable = true;
      enableMcpIntegration = true;
      settings = {
        autoshare = false;
        autoupdate = true;
        plugin = [
          "opencode-skills"
          "opencode-openai-codex-auth"
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
      context = ''
        - only use git commands when explicitly asked to
        - never run infrastructure commands without confirmation (tofu or terraform apply)
        - if building variables, always make sure to write input validation and error handling
      '';
    };
  };
}

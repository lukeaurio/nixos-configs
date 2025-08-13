{ config, pkgs, ...}:

{

  environment.systemPackages = with pkgs; [
    #programming
    tailscale
    python3Full
    python313
    poetry
    uv
    uv-sort
    opentofu
    qflipper
    git-conventional-commits
    graphviz
    keychain
    tealdeer
    lazygit
    bat
    tree
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        ms-python.python
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
        github.copilot
        github.copilot-chat
        mhutchie.git-graph
        waderyan.gitblame
      ];
    })

  ];


  services.tailscale.enable = true;
  programs.ssh.startAgent = true;


}

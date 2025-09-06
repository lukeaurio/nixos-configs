# NixOS: Quickly switch and apply configuration
nrs() {
    sudo nixos-rebuild switch "$@"
}

# Seach for recently run bash commands (If you lazy wink)
bl() {
    history | grep --color=auto "$@"
}

# NixOS: Edit configuration.nix
nec() {
    sudo ${EDITOR:-nano} /etc/nixos/configuration.nix
}

# NixOS: Search for packages
nix-search() {
    nix search nixpkgs "$@"
}

# Reload .bashrc
reload() {
    . ~/.zshrc
    echo "Reloaded ~/.bashrc"
}

# Bash completion for dotgit
if type _git &>/dev/null; then
  complete -o default -o nospace -F _git nixgit
fi

eval 'keychain --eval id_ed25519'
ssh-add ~/.ssh/id_ed25519

[[ "$TERM_PROGRAM" == "code" ]] && . "$(code --locate-shell-integration-path zsh)"

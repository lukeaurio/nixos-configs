# ~/.bashrc for NixOS users, using ash-compatible syntax
. ~/.git-prompt.sh
# Set a colorful prompt
PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " {%s}")'; PS1='\[\e[38;5;34;1;3m\]\u\[\e[0m\]: \w\[\e[38;5;129m\]${PS1_CMD1}\[\e[0m\] > '

# Enable color support for ls and grep if possible
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Useful navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='tree -L 1'
alias l='ls -lh'
alias la='ls -lAh'
alias ll='ls -lah'
alias nixgit='git --git-dir=$HOME/.nixos-config/ --work-tree=$HOME'


# NixOS: Quickly switch and apply configuration
nrs() {
    sudo nixos-rebuild switch "$@"
}

# Seach for recently run bash commands (If you lazy wink)
bash_lookup() {
    history | grep --color=auto "$@"
}

# NixOS: Edit configuration.nix
edit-nixos-config() {
    ${EDITOR:-nano} /etc/nixos/configuration.nix
}

# NixOS: Search for packages
nix-search() {
    nix search nixpkgs "$@"
}

# Reload .bashrc
reload() {
    . ~/.bashrc
    echo "Reloaded ~/.bashrc"
}

# Bash completion for dotgit
if type _git &>/dev/null; then
  complete -o default -o nospace -F _git nixgit
fi

eval 'keychain --eval --agents ssh id_ed25519'

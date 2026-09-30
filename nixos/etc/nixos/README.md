# Willberto.Biz Nix Configurations

This repository organizes My NixOS and Home Manager configuration as named
features. `flake.nix` starts the flake; `modules/default.nix` imports every
feature and host definition.

```
modules/
├── flake-schema.nix          # feature registry and host inventory
├── nixos/                    # NixOS features and system package groups
├── home/                     # Home Manager features
├── users/willberto.nix       # My Home Manager profile
└── hosts/framework-nixos.nix # Framework-specific composition
```

Features register NixOS modules under `flake.modules.nixos` and Home Manager
modules under `flake.modules.homeManager`. A host imports the feature names it
needs. That keeps host files small and lets another machine reuse the same
desktop, development, shell, or user configuration.

`hardware-configuration.nix` stays outside the feature tree. It contains the
Framework's filesystem UUIDs and other machine-local hardware facts, and the
Framework host imports it directly.

## First installation

On a NixOS installation with flakes enabled, clone the repository into the home directory and symlink the contents of this foleder to etc/nixos (or don't, this can be your config source canonically if you so choose):

```sh
cd ~
git clone https://github.com/lukeaurio/nixos-configs.git
cd "$HOME/nixos/etc/nixos"
sudo nixos-rebuild switch --flake .#framework-nixos
```

The first `nixos-rebuild switch` installs the Home Manager profile that defines
`flakeup`; use the full command above until it has completed. The command
activates the selected configuration immediately. With a Git-backed flake, make
sure the files you expect Nix to use are tracked before rebuilding.

## Rebuild and upgrade

After editing this repository, rebuild the currently pinned inputs without
changing `flake.lock`:

```sh
cd "$HOME/.nixos-config
# or z /etc/nixos if you want to use zoxide
sudo nixos-rebuild switch --flake .#framework-nixos
```

To intentionally refresh every flake input and apply the result, run:

```sh
flakeup
```

`flakeup` does a refesh of the flake sources and then runs nixos-rebuild-switch.

```sh
export NIXOS_CONFIG_DIR=/path/to/nixos-configs
export NIXOS_CONFIG_HOST=your-host-name
flakeup
```

## Add a machine

1. Add a host module under `modules/hosts/` and import it from
   `modules/default.nix`.
2. Define its hardware and host-specific settings in a
   `flake.modules.nixos.<host>` feature.
3. Add `flake.hosts.<host>` with the platform and the selected feature modules.
4. Reuse `config.flake.modules.homeManager.willberto`, or assemble a separate
   user profile under `modules/users/`.

`flake.hosts` produces `nixosConfigurations`, so `flake.nix` does not need a
new host entry.

## Current experiment settings

No Nix evaluation, build, activation, lock resolution, or migration command
has been run. The direct `flake-parts` lock entry reuses the revision already
present in `flake.lock`.

Automatic upgrades rebuild the immutable source of the installed flake and
forbid lock-file updates. Automatic garbage collection is disabled until a
retention policy is chosen.

MyNixOS informed the system-package and Zsh option usage. Links to those option
references are kept beside the relevant settings.
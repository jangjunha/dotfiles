# dotfiles

My personal development environment configuration managed with [Home Manager](https://github.com/nix-community/home-manager).

## Prerequisites

### Install Nix

Vanilla upstream [Nix][nix] with [Nix installer from Determinate Systems][nix-installer-determinate]

```bash
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --prefer-upstream-nix
```

or check https://docs.determinate.systems/getting-started/individuals/#install

## Installation

```bash
git clone https://github.com/jangjunha/dotfiles /etc/nix-darwin
cd /etc/nix-darwin
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#junha-air2022
```

[nix]: https://nixos.org/
[nix-installer-determinate]: https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#determinate-nix-installer

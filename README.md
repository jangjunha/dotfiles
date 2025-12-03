# dotfiles

My personal development environment configuration managed with [Home Manager](https://github.com/nix-community/home-manager).

## Prerequisites

### Install Determinate Nix

```bash
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

or check https://docs.determinate.systems/getting-started/individuals/#install

## Installation

```bash
git clone https://github.com/jangjunha/dotfiles ~/.config/home-manager
cd ~/.config/home-manager
nix run home-manager switch
```

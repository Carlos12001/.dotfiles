# .dotfiles

This repository is a save for my dotfiles.

## Nvim

### Cliboard

If clipboard doesn't work you need to install also

```bash
sudo pacman -S xclip
```

### Lazy Vim

```bash
# Add the official Neovim PPA for the latest version
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y git curl neovim ripgrep fd-find unzip build-essential \
    python3-venv python3-pip luarocks nodejs npm

# Link "fd-find" as "fd"
sudo ln -s $(which fdfind) /usr/local/bin/fd

# Upgrade the Python Neovim module
pip install --user --upgrade pynvim

# Install Tree-sitter CLI
sudo npm install -g tree-sitter-cli

# Recommended tools
sudo apt install -y fzf lazygit
```

#### WSL

To use the same Neovim configuration on both Windows and WSL:

```bash
mkdir -p ~/.config
ln -s /mnt/c/Users/carlos/AppData/Local/nvim ~/.config/nvim
```

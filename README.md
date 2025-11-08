# .dotfiles

This repository stores my personal configuration files for development tools and environments.

## System Setup

### Linux (Debian/Ubuntu-based)

```bash
sudo apt update
sudo apt install -y git curl zsh unzip build-essential ripgrep fd-find fzf
```

#### Change Default Editor

```bash
sudo update-alternatives --config editor
```

#### Enable Password Feedback in Terminal

By default, Linux hides visual feedback when entering passwords (for example when using `sudo`).

```bash
sudo visudo
```

Then add or modify the following line:

```bash
Defaults        env_reset,pwfeedback
```

### Windows

```powershell
# === Essential packages ===
winget install Git.Git --accept-package-agreements --accept-source-agreements
winget install 7zip.7zip --accept-package-agreements --accept-source-agreements
winget install Mozilla.Firefox --accept-package-agreements --accept-source-agreements
winget install Microsoft.PowerShell --accept-package-agreements --accept-source-agreements
winget install Python.Python.3.13 --accept-package-agreements --accept-source-agreements
winget install KDE.Okular --accept-package-agreements --accept-source-agreements
winget install --id Flameshot.Flameshot --version 12.1.0 --accept-package-agreements --accept-source-agreements
winget install  Valve.Steam --accept-package-agreements --accept-source-agreements
winget install  OBSProject.OBSStudio --accept-package-agreements --accept-source-agreements

# === Optional utilities ===
winget install Gyan.FFmpeg --accept-package-agreements --accept-source-agreements
winget install VideoLAN.VLC --accept-package-agreements --accept-source-agreements
winget install ArminOsaj.AutoDarkMode --accept-package-agreements --accept-source-agreements
winget install Telegram.TelegramDesktop --accept-package-agreements --accept-source-agreements
winget install MiKTeX.MiKTeX --accept-package-agreements --accept-source-agreements
winget install WinDirStat.WinDirStat --accept-package-agreements --accept-source-agreements
winget install BleachBit.BleachBit --accept-package-agreements --accept-source-agreements
winget install pCloudAG.pCloudDrive --accept-package-agreements --accept-source-agreements

# === Microsoft Store apps ===

# WhatsApp Windows
winget install 9NKSQGP7F2NH --accept-package-agreements --accept-source-agreements
# Nvidia Control Panel
winget install 9NF8H0H7WMLT --accept-package-agreements --accept-source-agreements
```

## Zsh

Set **Zsh** as the default shell on Linux:

```bash
chsh -s $(which zsh)
exit
```

### Oh My Zsh

Install **Oh My Zsh** and the **Powerlevel10k** theme:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
"${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

Then set the theme in `~/.zshrc`:

```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
```

Finally, apply changes:

```bash
source ~/.zshrc
```

> [!NOTE]
> When using **WSL** with **Docker Desktop**, you may sometimes see this error:
>
> ```bash
> compinit:527: no such file or directory: /usr/share/zsh/vendor-completions/_docker
> ```
>
> This occurs because Docker Desktop mounts its CLI into WSL, but does **not include** Zsh completion files inside WSL.  
> To prevent this message (even when Docker Desktop is off), add the following to your `~/.zshrc`:
>
> ```bash
> # Prevent Docker completion error when Docker Desktop is disabled
> if [[ -f /usr/share/zsh/vendor-completions/_docker ]]; then
>   fpath=($fpath /usr/share/zsh/vendor-completions)
> else
>   plugins=(${plugins:#docker})
> fi
> autoload -Uz compinit
> compinit -i
> ```
>
> This ensures Zsh only loads Docker completions if they exist, avoiding warnings when Docker is inactive.

## Neovim

### Installation

#### Windows

```powershell
winget install Neovim.Neovim --accept-package-agreements --accept-source-agreements
```

#### Linux

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y neovim
```

### Clipboard Support (Arch Linux)

```bash
sudo pacman -S xclip
```

## LazyVim

Follow the instructions below to set up **LazyVim** as your Neovim configuration.

<https://www.lazyvim.org/installation>

### Linux / WSL Setup

Install all dependencies required for **LazyVim** to function properly:

```bash
sudo apt install -y git curl neovim ripgrep fd-find unzip build-essential \
    python3-venv python3-pip luarocks nodejs npm

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

# Link "fd-find" as "fd"
sudo ln -s $(which fdfind) /usr/local/bin/fd || true

# Upgrade Python support for Neovim (PEP 668 safe)
pip install --user --upgrade pynvim --break-system-packages

# Add local Python bin path to Zsh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Install Tree-sitter CLI (required for parser compilation)
sudo npm install -g tree-sitter-cli

npm install -g neovim

# Recommended tools
sudo apt install -y fzf
```

### Windows Setup

Install dependencies required for **LazyVim** under Windows:

```powershell
# === Core dependencies for LazyVim ===
winget install OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements
winget install BrechtSanders.WinLibs.POSIX.UCRT --accept-package-agreements --accept-source-agreements

# === CLI tools required by LazyVim ===
winget install BurntSushi.ripgrep.MSVC --accept-package-agreements --accept-source-agreements
winget install sharkdp.fd --accept-package-agreements --accept-source-agreements
winget install junegunn.fzf --accept-package-agreements --accept-source-agreements
winget install JesseDuffield.lazygit --accept-package-agreements --accept-source-agreements
winget install 7zip.7zip --accept-package-agreements --accept-source-agreements
winget install curl --accept-package-agreements --accept-source-agreements

# === Python support for Neovim ===
python -m pip install --user --upgrade pynvim

# === Tree-sitter CLI (required for parser compilation) ===
npm install -g tree-sitter-cli
npm install -g neovim
```

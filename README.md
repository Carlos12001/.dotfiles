# .dotfiles

This repository is a save for my dotfiles.

# Nvim

## Cliboard

If clipboard doesn't work you need to install also 

```
Sudo pacman -S xclip
```

# Git

## Credential Manager for Github 

- Watch the video (https://youtu.be/-vE18egR0SA)

- Then install libsecret, you need install also

```bash
sudo pacman -Syu libsecret 
```

```bash
sudo pacman -S gnome-keyring
```

```bash
git config --global credential.helper /lib/git-core/git-credential-libsecret
```

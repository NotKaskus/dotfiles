<div align="center">
  <h1><code>~/.dotfiles</code></h1>
  <p>
    <i>My dotfiles for configuring for literally everything (automatically!)</i>
  </p>
  <a aria-label="GitHub License" href="https://github.com/NotKaskus/dotfiles/blob/main/license.md">
    <img src="https://img.shields.io/github/license/NotKaskus/dotfiles?color=%2334D058&logo=github&style=flat-square&label=License">
  </a>
  <a aria-label="Issues" href="https://github.com/NotKaskus/dotfiles/issues">
    <img src="https://img.shields.io/github/issues/NotKaskus/dotfiles?color=%2334D058&logo=github&style=flat-square&label=Issues">
  </a>
</div>

---

## ⚡️ Lets Goooooo

**Before you start**: If you have `~/.gitconfig` file, please copy and paste your data to `~/.config/general/gitconfig` file (it will be created after installation). Don't forget to remove old `~/.gitconfig` file! This file will be automatically included in new `~/.gitconfig` file.

```bash
bash <(curl -s https://raw.githubusercontent.com/NotKaskus/dotfiles/main/lets-go.sh)
```

This will execute the quick setup script (in [`lets-go.sh`](https://github.com/NotKaskus/dotfiles/blob/main/lets-go.sh)), which just clones the repo (if not yet present), then executes the [`run-install.sh`](https://github.com/NotKaskus/dotfiles/blob/main/run-install.sh) script. You can re-run this at anytime to update the dotfiles. You can also optionally pass in some variables to change the install location (`DOTFILES_DIR`) and source repo (`DOTFILES_REPO`) to use your fork.

The install script [does several things](#-content), it takes care of checking dependencies are met, updating dotfiles and symlinks, configuring CLI (Vim, Tmux, ZSH, etc), and will prompt the user to install listed packages, update the OS and apply any system preferences. The script is idempotent, so it can be run multiple times without changing the result, beyond the initial application.

## 📦 Content

- `config/` - Contains configuration files for various tools and environments.
  - `general/` - General configuration files like `.bashrc`, `.curlrc`, `.gitconfig`, etc.
  - `gnome/` - Configuration files for [GNOME](https://extensions.gnome.org/).
  - `nvim/` - Configuration files for [Neovim](https://github.com/NvChad/NvChad).
  - `tmux/` - Configuration files for [Tmux](https://github.com/tmux/tmux/).
  - `vim/` - Configuration files for [Vim](https://www.vim.org/).
  - `zsh/` - Configuration files for [Zsh](https://github.com/robbyrussell/oh-my-zsh).
- `lets-go.sh` - Shell script to check if required lib such as [git](https://git-scm.com/) is installed.
- `lib/` - Contains libraries.
  - `dotbot/` - [Dotbot](https://github.com/anishathalye/dotbot) for managing dotfiles.
  - `tpm/` - [Tpm](https://github.com/tmux-plugins/tpm) for managing Tmux plugins.
- `run-install.sh` - Shell script for installation.
- `scripts/` - Contains various utility scripts.
- `symlinks.yaml` - YAML file for managing symbolic links using [dotbot](https://github.com/tmux-plugins/tpm).
- `utils/` - Contains utility scripts like `am-i-online.sh`, `color-map.sh`, `death-to-dotfiles.sh`, etc.

## ⁉️ Issues

If you have find any issues with the repository please create [new issue here](https://github.com/NotKaskus/dotfiles/issues)

## 📋 License

This project is licensed under the MIT. See the [LICENSE](https://github.com/NotKaskus/dotfiles/blob/main/license.md) file for details
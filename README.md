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

- `zsh/` - [Zsh](https://www.zsh.org/) config with [Oh My Zsh](https://ohmyz.sh/), includes aliases for Git, Debian, and [TheFuck](https://github.com/nvbn/thefuck)
  - `oh-my-zsh` - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete) plugins. [(See all plugins)](https://github.com/NotKaskus/dotfiles/blob/main/run-install.sh)
  - `oh-my-posh` - For that [beautiful terminal](https://github.com/JanDeDobbeleer/oh-my-posh/) look.
  - `brew` - Using [homebrew](https://github.com/Homebrew/brew) to install libs that are not available on ubuntu apt-install.
- `nvim/` - Use [Nvchad](https://nvchad.com/) plugin cause why not?
- `dotbot/` - [Dotbot](https://github.com/anishathalye/dotbot) repository managing this dotfiles.
- `tmux/` - Use [Tpm](https://github.com/tmux-plugins/tpm) for installing tmux plugins.

## ⁉️ Issues

If you have find any issues with the repository please create [new issue here](https://github.com/NotKaskus/dotfiles/issues)

## 📋 License

This project is licensed under the MIT. See the [LICENSE](https://github.com/NotKaskus/dotfiles/blob/main/license.md) file for details
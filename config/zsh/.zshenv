#  ~/.zshenv
# Core envionmental variables
# Locations configured here are requred for all other files to be correctly imported

# Set XDG directories
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_LIB_HOME="${HOME}/.local/lib"
export XDG_CACHE_HOME="${HOME}/.cache"

# Set default applications
export EDITOR="vim"
export TERMINAL="konsole"
export BROWSER="chrome"
export PAGER="less"

## Respect XDG directories
export ADOTDIR="${XDG_CACHE_HOME}/zsh/antigen"
export OPENSSL_DIR="/usr/local/ssl"
export CURL_HOME="${XDG_CONFIG_HOME}/curl"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export GIT_CONFIG="${XDG_CONFIG_HOME}/git/.gitconfig"
export LESSHISTFILE="-" # Disable less history.
export TMUX_PLUGIN_MANAGER_PATH="${XDG_DATA_HOME}/tmux/plugins"
export WGETRC="${XDG_CONFIG_HOME}/wget/.wgetrc"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZLIB="${ZDOTDIR}/lib"
export PYENV_ROOT="$HOME/.pyenv"

# source $XDG_CONFIG_HOME/zsh/.zshrc

# Encodings, languges and misc settings
export LANG='en_GB.UTF-8';
export PYTHONIOENCODING='UTF-8';
export LC_ALL='C';
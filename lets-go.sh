#!/usr/bin/env bash

# If not already set, specify dotfiles destination directory and source repo
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Documents/config/dotfiles}"
DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/NotKaskus/dotfiles.git}"

# Print starting message
echo -e "\033[1;36m""NotKaskus/Dotfiles Installation Script 🧰
\033[0;36mThis script will install or update specified dotfiles:
- From \033[4;36m${DOTFILES_REPO}\033[0;36m
- Into \033[4;36m${DOTFILES_DIR}\033[0;36m
Be sure you've read and understood the what will be applied.\033[0m\n"

# Core commands
commands=("brew" "git" "curl" "bash" "fish" "vim" "zsh")

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check each command and update the flag if any are missing
for cmd in "${commands[@]}"; do
    if ! command_exists "$cmd"; then
        echo "$cmd is not installed."
        any_missing=true
    fi
done

# If any command is missing, run the installation script
if [ "$any_missing" = true ]; then
    echo "One or more commands are missing, installing prerequisites..."
    bash <(curl -s  -L 'https://raw.githubusercontent.com/NotKaskus/dotfiles/main/scripts/prerequisites.sh')
else
    echo "All necessary commands are installed."
fi

# If dotfiles not yet present then clone
if [[ ! -d "$DOTFILES_DIR" ]]; then
  mkdir -p "${DOTFILES_DIR}" && \
  git clone --recursive ${DOTFILES_REPO} ${DOTFILES_DIR}
	cd ${DOTFILES_DIR} && \
  git submodule update --init --recursive
fi

# Execute setup or update script
cd "${DOTFILES_DIR}" && \
chmod +x ./run-install.sh && \
./run-install.sh --no-clear

# EOF
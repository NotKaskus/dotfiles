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

# If dependencies not met, install them
core_packages=(
  'git' # Needed to fetch dotfiles
  'vim' # Needed to edit files
  'zsh' # Needed as bash is crap
  'fish' # Needed as bash is crap
  'brew' # Needed as bash is crap
)

for package in "${core_packages[@]}"; do
  if ! command -v $package &> /dev/null; then
    echo "$package could not be found"
    bash <(curl -s  -L 'https://raw.githubusercontent.com/NotKaskus/dotfiles/main/scripts/installs/prerequisites.sh')
  fi
done

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
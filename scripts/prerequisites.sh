#!/usr/bin/env bash

# Color variables
PURPLE='\033[0;35m'
YELLOW='\033[0;93m'
LIGHT='\x1b[2m'
RESET='\033[0m'

# List of apps to install
core_packages=(
  'git' # Needed to fetch dotfiles
  'vim' # Needed to edit files
  'zsh' # Needed as bash is crap
  'fish' # Needed as bash is crap
  'cargo' # Needed for Rust
)

# Shows help menu / introduction
function print_usage () {
  echo -e "${PURPLE}Prerequisite Dependency Installation Script${LIGHT}\n"\
  "There's a few packages that are needed in order to continue with setting up dotfiles.\n"\
  "This script will detect distro and use appropriate package manager to install apps.\n"\
  "Elavated permissions may be required. Ensure you've read the script before proceeding."\
  "\n${RESET}"
}

function install_debian () {
  echo -e "${PURPLE}Installing ${1} via apt-get${RESET}"
  sudo apt update && sudo apt upgrade -y
  sudo apt install $1
}

function install_windows () {
	if ! hash choco 2> /dev/null; then
		echo -e "${PURPLE}Chocolatey is not installed, installing now...${RESET}"
		/bin/bash -c "$(curl -fsSL https://chocolatey.org/install.sh)"
	fi

	echo -e "${PURPLE}Installing ${1} via choco${RESET}"
	choco install $1
}

# Install NVM - Node Version Manager
if ! hash nvm 2> /dev/null; then
  echo -e "${PURPLE}Installing nvm via curl${RESET}"
  bash -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh)"
else
  echo -e "${YELLOW}${app} is already installed, skipping${RESET}"
fi

# Install Brew - Package manager for MacOS/Linux
if ! hash brew 2> /dev/null; then
  echo -e "${PURPLE}Installing homebrew via curl${RESET}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> ~/.zshrc
  export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
else
  echo -e "${YELLOW}Brew is already installed, skipping${RESET}"
fi

# Detect OS type, then triggers install using appropriate package manager
function multi_system_install () {
  app=$1
  if [ -f "/etc/debian_version" ] && hash apt 2> /dev/null; then
    install_debian $app # Debian via apt-get
  elif [[ "$(uname)" == MINGW* ]]; then
    install_windows $app # Windows via choco or some other package manager
  else
		echo -e "${YELLOW}Skipping ${app}, as couldn't detect system type ${RESET}"
  fi
}

# Show usage instructions, help menu
print_usage
if [[ $* == *"--help"* ]]; then exit; fi

# Ask user if they'd like to proceed
if [[ ! $* == *"--auto-yes"* ]] ; then
  echo -e "${PURPLE}Are you happy to continue? (y/N)${RESET}"
  read -t 15 -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Proceeding was rejected by user, exiting...${RESET}"
    exit 0
  fi
fi

# For each app, check if not present and install
for app in ${core_packages[@]}; do
  if ! hash "${app}" 2> /dev/null; then
    multi_system_install $app
  else
    echo -e "${YELLOW}${app} is already installed, skipping${RESET}"
  fi
done

# All done
echo -e "\n${PURPLE}Jobs complete, exiting...${RESET}"
exit 0

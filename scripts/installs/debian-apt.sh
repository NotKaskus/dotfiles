#!/usr/bin/env bash

# Apps to be installed via apt-get
debian_apps=(
  # Essentials
  'git'           # Version control
  'neovim'        # Text editor
  'ranger'        # Directory browser
  'tmux'          # Term multiplexer
  'wget'          # Download files

  # CLI Power Basics
  'ctags'         # Indexing of file info + headers
  'exa'           # Listing files with info (better ls)
  'fzf'           # Fuzzy file finder and filtering
  'jq'            # JSON parser, output and query files
  'most'          # Multi-window scroll pager (better less)
  'scrot'         # Screenshots programmatically via CLI
  'thefuck'       # Auto-correct miss-typed commands
  'tree'          # Directory listings as tree structure
  'xsel'          # Copy paste access to the X clipboard
  'rip'           # Deletion tool (better rm)

  # Languages, compilers, runtimes, etc
  'node'           # Node.js
  'nvm'            # Switching node versions

  # Security Utilities
  'openssl'       # Cryptography and SSL/TLS Toolkit
  'rkhunter'      # Search / detect potential root kits

  # Monitoring, management and stats
  'bmon'          # Bandwidth utilization monitor
  'ctop'          # Container metrics and monitoring
  'glances'       # Resource monitor + web and API
  'goaccess'      # Web log analyzer and viewer
  'speedtest-cli' # Command line speed test utility

  # CLI Fun
  'cowsay'        # Outputs message with ASCII art cow
  'figlet'        # Outputs text as 3D ASCII word art
  'lolcat'        # Rainbow colored terminal output
  'neofetch'      # Show off distro and system info
)

declare -A additional_apps

additional_apps=(
  "aria2"
  "broot"
  "diff-so-fancy"
  "bat"
  "just"
  "zoxide"
  "tealdeer"
  "hyperfine"
  "procs"
  "ripgrep"
  "sd"
  "tokei"
  "trash-cli"
  "clamav"
  "cryptsetup"
  "gnupg"
  "starship"
)

ubuntu_repos=(
  'main'
  'universe'
  'restricted'
  'multiverse'
)

debian_repos=(
  'main'
  'contrib'
)

# Colors
PURPLE='\033[0;35m'
YELLOW='\033[0;93m'
CYAN_B='\033[1;96m'
LIGHT='\x1b[2m'
RESET='\033[0m'

PROMPT_TIMEOUT=15 # When user is prompted for input, skip after x seconds

# If set to auto-yes - then don't wait for user reply
if [[ $* == *"--auto-yes"* ]]; then
  PROMPT_TIMEOUT=0
  REPLY='Y'
fi

# Print intro message
# TODO: Add windows support soon
echo -e "${PURPLE}Starting Debian / Ubuntu package install & update script"
echo -e "${YELLOW}Before proceeding, ensure your happy with all the packages listed in \e[4m${0##*/}"
echo -e "${RESET}"

# Check if running as root, and prompt for password if not
if [ "$EUID" -ne 0 ]; then
  echo -e "${PURPLE}Elevated permissions are required to adjust system settings."
  echo -e "${CYAN_B}Please enter your password...${RESET}"
  sudo -v
  if [ $? -eq 1 ]; then
    echo -e "${YELLOW}Exiting, as not being run as sudo${RESET}"
    exit 1
  fi
fi

# Check apt-get actually installed
if ! hash apt 2> /dev/null; then
  echo "${YELLOW_B}apt doesn't seem to be present on your system. Exiting...${RESET}"
  exit 1
fi

# Update apt-get
echo -e "${PURPLE}Updating apt-get...${RESET}"
sudo apt update && sudo apt upgrade -y

# Enable upstream package repositories
echo -e "${CYAN_B}Would you like to enable listed repos? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if ! hash add-apt-repository 2> /dev/null; then
    sudo apt install --reinstall software-properties-common
  fi
  # If Ubuntu, add Ubuntu repos
  if lsb_release -a 2>/dev/null | grep -q 'Ubuntu'; then
    for repo in ${ubuntu_repos[@]}; do
      echo -e "${PURPLE}Enabling ${repo} repo...${RESET}"
      sudo add-apt-repository $repo
    done
  else
    # Otherwise, add Debian repos
    for repo in ${debian_repos[@]}; do
      echo -e "${PURPLE}Enabling ${repo} repo...${RESET}"
      sudo add-apt-repository $repo
    done
  fi
fi

# Prompt user to update package database
echo -e "${CYAN_B}Would you like to update package database? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${PURPLE}Updating database...${RESET}"
  sudo apt update
fi

# Prompt user to upgrade currently installed packages
echo -e "${CYAN_B}Would you like to upgrade currently installed packages? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${PURPLE}Upgrading installed packages...${RESET}"
  sudo apt upgrade
fi

# Prompt user to clear old package caches
echo -e "${CYAN_B}Would you like to clear unused package caches? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${PURPLE}Freeing up disk space...${RESET}"
  sudo apt autoclean
fi

# Prompt user to install all listed apps
echo -e "${CYAN_B}Would you like to install listed apps? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${PURPLE}Starting install...${RESET}"
  for app in ${debian_apps[@]}; do
    if hash "${app}" 2> /dev/null; then
      echo -e "${YELLOW}[Skipping]${LIGHT} ${app} is already installed${RESET}"
    else
      echo -e "${PURPLE}[Installing]${LIGHT} Downloading ${app}...${RESET}"
      sudo apt install ${app} --assume-yes
    fi
  done
fi

# Prompt user to install all listed apps
echo -e "${CYAN_B}Would you like to install additional apps? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${PURPLE}Starting install...${RESET}"
  # Install NVM
  if hash "nvm" 2> /dev/null; then
    echo -e "${YELLOW}[Skipping]${LIGHT} NVM is already installed${RESET}"
  else
    echo -e "${PURPLE}[Installing]${LIGHT} Downloading NVM...${RESET}"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
  fi

  for software in "${!additional_apps[@]}"; do
    if hash "${software}" 2> /dev/null; then
      echo -e "${YELLOW}[Skipping]${LIGHT} ${software} is already installed${RESET}"
    else
      echo -e "${PURPLE}[Installing]${LIGHT} Downloading ${software}...${RESET}"
      brew install "${software}"
    fi
  done
fi

echo -e "${PURPLE}Finished installing / updating Debian/Ubuntu packages.${RESET}"

# EOF
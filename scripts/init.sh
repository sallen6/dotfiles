#!/bin/bash

declare -a dependencies=("zsh" "vim" "stow")

install_dependencies() {
    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo "Installing $dep..."
            case "$(uname -s)" in
                Linux*) sudo apt-get install -y "$dep" ;; # Debian/Ubuntu
                Darwin*) brew install "$dep" ;; # macOS (requires Homebrew)
                *) echo "Unsupported OS. Please install $dep manually." ;;
            esac
        else
            echo "$dep is already installed."
        fi
    done
}

install_dependencies

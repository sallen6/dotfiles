eval `keychain --eval --agents ssh id_ed25519`

# If you had to create ~/.bash_profile, these lines may also be needed
# to load your ~/.bashrc config
if [ -n "$ZSH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.zshrc" ]; then
        . "$HOME/.zshrc"
    fi
fi

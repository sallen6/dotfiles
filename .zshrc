# Set up the prompt

setopt PROMPT_SUBST
autoload -Uz vcs_info # Include version control in prompt if available

zstyle ':vcs_info:git:*' formats '%b '

precmd () {
    vcs_info
    if [[ -n ${vcs_info_msg_0_} ]]; then
        STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
        if [[ -n $STATUS ]]; then
            VCS_COLOR='red'
        else
            VCS_COLOR='green'
        fi
    else
        VCS_COLOR='red'
    fi

    setopt PROMPT_SUBST
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        PROMPT='%F{cyan}%*%f %F{magenta}%m %F{yellow}${(%):-%~} %F{'$VCS_COLOR'}${vcs_info_msg_0_}%f%# '
    else
        PROMPT='%F{cyan}%*%f %F{yellow}${(%):-%~} %F{'$VCS_COLOR'}${vcs_info_msg_0_}%f%# '
    fi
}

setopt histignorealldups sharehistory

# Use vi keybindings
bindkey -v

# Set editor to vim
export EDITOR=vim

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

autoload zmv

# Aliases
alias zcp='zmv -C' zln='zmv -L'
alias ls='ls --color=auto'
alias la='ls -A --color=auto'
alias please='sudo !!'
alias grep='grep --color=auto'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

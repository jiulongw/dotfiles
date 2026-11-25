typeset -aU path

function prepend_path() {
    # prepend path if directory exists, and the path is not in the $path array.
    # this is to prevent unexpectedly change the order of $path when zsh is nested (such as in tmux).
    if [[ -d $1 && -z $path[(r)$1] ]]; then
        path=($1 $path)
    fi
}

function append_path() {
    # append path if directory exists, we don't need to worry adding path twice,
    # because `typeset -aU path` in the very beginning will do that for us.
    if [[ -d $1 ]]; then
        path+=($1)
    fi
}

[[ -a $HOME/.zshrc.local ]] && source ~/.zshrc.local

prepend_path "$HOME/.local/bin"
append_path "$GOPATH/bin"
append_path "$ANDROID_HOME/platform-tools"
append_path "$ANDROID_HOME/tools"
append_path "$ANDROID_HOME/cmdline-tools/latest/bin"
append_path "$NDK_ROOT"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

alias gd="git diff"
alias gst="git status"
alias k="kubectl"

# >>> conda initialize >>>
if [[ -d "/opt/homebrew/Caskroom/miniconda/base" ]]; then
    CONDA_HOME=/opt/homebrew/Caskroom/miniconda/base
else
    CONDA_HOME=$HOME/miniconda3
fi

if [[ -d "$CONDA_HOME" ]]; then
    __conda_setup=`"${CONDA_HOME}/bin/conda" 'shell.zsh' 'hook' 2> /dev/null`
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "${CONDA_HOME}/etc/profile.d/conda.sh" ]; then
            . "${CONDA_HOME}/etc/profile.d/conda.sh"
        else
            prepend_path "${CONDA_HOME}/bin"
        fi
    fi
    unset __conda_setup
fi
# <<< conda initialize <<<

export PATH
export CONDA_HOME
export EDITOR='vim'

if which fzf > /dev/null 2>&1; then
  source <(fzf --zsh)
fi

# History
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt hist_ignore_all_dups
setopt hist_ignore_space

# repo-cli completion
[[ -a $HOME/dev/dotfiles/repo-cli-completion.zsh ]] && source $HOME/dev/dotfiles/repo-cli-completion.zsh

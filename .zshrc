autoload -Uz compinit && compinit
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

function source_if_exists() {
    if [[ -r $1 ]]; then
        source $1
    fi
}

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
source_if_exists "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

source_if_exists "$HOME/.zshrc.local"

prepend_path "$HOME/.local/bin"
append_path "$GOPATH/bin"
append_path "$ANDROID_HOME/platform-tools"
append_path "$ANDROID_HOME/tools"
append_path "$ANDROID_HOME/cmdline-tools/latest/bin"
append_path "$NDK_ROOT"

export NVM_DIR="$HOME/.nvm"
source_if_exists "$NVM_DIR/nvm.sh" 
source_if_exists "$NVM_DIR/bash_completion"

source_if_exists "$HOME/.cargo/env"

alias gaa="git add -A"
alias gc="git commit"
alias gd="git diff"
alias glog="git log --oneline"
alias gp="git push"
alias gst="git status"

alias k="kubectl"
alias ls="eza --icons=always"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

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
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# repo-cli completion
source_if_exists "$HOME/.config/repo-cli/repo-cli-completion.zsh"

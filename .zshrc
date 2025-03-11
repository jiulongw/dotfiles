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

prepend_path "$HOME/bin"
append_path "$GOPATH/bin"
append_path "$ANDROID_HOME/platform-tools"
append_path "$ANDROID_HOME/tools"
append_path "$ANDROID_HOME/cmdline-tools/latest/bin"
append_path "$NDK_ROOT"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

alias yb="yarn build"
alias yf="yarn format"
alias yt="yarn test"
alias em="emacsclient -a '' -nc"
alias emk="emacsclient -e '(kill-emacs)'"
alias icat="kitty +kitten icat"
alias kssh="kitty +kitten ssh"

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

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# ZSH_THEME="robbyrussell"
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITOR='vim'

PROMPT='$(git_prompt_info)[%{$fg[red]%}%24<...<%~%<<%{$reset_color%}'
if [[ -n $SSH_CONNECTION ]]; then
  PROMPT+='%{$fg[cyan]%}@%m%{$reset_color%}'
fi
PROMPT+=']%(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[gray]%}(%{$fg_no_bold[yellow]%}%B"
ZSH_THEME_GIT_PROMPT_SUFFIX="%b%{$fg_bold[gray]%})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✱"

if which fzf > /dev/null 2>&1; then
  source <(fzf --zsh)
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

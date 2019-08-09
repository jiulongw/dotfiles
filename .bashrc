[[ `uname` == "Linux" ]] && alias ls="ls --color=auto"
[[ `uname` == "Darwin" ]] && alias ls="ls -FG"
alias grep="grep --color=auto"
alias ..="cd .."

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

HISTCONTROL=ignoreboth:erasedups
HISTFILESIZE=
shopt -s histappend
HISTSIZE=10000

[[ -d ~/bin ]] && export PATH=~/bin:$PATH
[[ -d ~/go/bin ]] && export PATH=~/go/bin:$PATH

[[ -a ~/.bashrc.local ]] && source ~/.bashrc.local
[[ -a ~/.git-prompt.sh ]] && source ~/.git-prompt.sh
[[ -a ~/.git-completion.bash ]] && source ~/.git-completion.bash

HOST_NAME=""
[[ $SSH_CLIENT != "" ]] && HOST_NAME="\u@\h "

function title {
  printf "\033]0;%s\007" "$1"
}

__exit_status() {
  if [ $? != 0 ]; then
    printf -- "! "
  fi
}

__conda_env() {
  if [ "$CONDA_DEFAULT_ENV" != "" ]; then
    printf -- "($CONDA_DEFAULT_ENV) "
  fi
}

__hist_util() {
  history -n
  history -w
  history -c
  history -r
}

GIT_PS1_SHOWCOLORHINTS=1
PROMPT_COMMAND='__hist_util; __git_ps1 "\$(__exit_status)\$(__conda_env)$HOST_NAME\W" " \\\$ "'

mkdir -p /tmp/vim

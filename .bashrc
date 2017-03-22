[[ `uname` == "Linux" ]] && alias ls="ls --color=auto"
[[ `uname` == "Darwin" ]] && alias ls="ls -FG"
alias grep="grep --color=auto"
alias ..="cd .."

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=
export HISTSIZE=

[[ -d ~/bin ]] && export PATH=~/bin:$PATH

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

GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
PROMPT_COMMAND='__git_ps1 "\$(__exit_status)$HOST_NAME\W" " \\\$ "'

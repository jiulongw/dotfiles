alias less='less -R'
alias grep='grep --color=auto'

if [[ `uname` == 'Linux' ]]
then
  alias ls='ls --color=auto'
else
  alias ls='ls -FG'
fi

alias emacs='emacsclient --alternate-editor="" -c'


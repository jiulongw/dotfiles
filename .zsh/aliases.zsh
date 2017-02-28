alias less='less -R'
alias grep='grep --color=auto'

if [[ `uname` == 'Linux' ]]
then
  alias ls='ls --color=auto'
else
  alias ls='ls -FG'
fi

function title {
  printf "\033]0;%s\007" "$1"
}

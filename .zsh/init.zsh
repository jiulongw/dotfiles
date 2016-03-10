slim_path=`dirname $0`
fpath=($slim_path $slim_path/prompt $fpath)

autoload -U promptinit && promptinit
prompt minimal

setopt autocd
setopt extendedglob

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PATH=$PATH:~/.bin

WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

source $slim_path/history.zsh
source $slim_path/keys.zsh
source $slim_path/completion.zsh
source $slim_path/aliases.zsh

if [[ -a ~/.local.zsh ]]; then
  source ~/.local.zsh
fi

# Setup proper term for emacs
[[ $TERM == eterm-color ]] && export TERM=xterm

if [ -n "$INSIDE_EMACS" ]; then
  chpwd() { print -P "\033AnSiTc %d" }
  print -P "\033AnSiTu %n"
  print -P "\033AnSiTc %d"
fi


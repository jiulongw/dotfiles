slim_path=`dirname $0`
fpath=($slim_path $slim_path/prompt $fpath)

autoload -U promptinit && promptinit
prompt minimal

setopt autocd
setopt extendedglob

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

source $slim_path/history.zsh
source $slim_path/keys.zsh
source $slim_path/completion.zsh
source $slim_path/aliases.zsh


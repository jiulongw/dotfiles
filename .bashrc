[[ `uname` == "Linux" ]] && alias ls="ls --color=auto"
[[ `uname` == "Darwin" ]] && alias ls="ls -FG"
alias grep="grep --color=auto"
alias ..="cd .."

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
[[ -d ~/bin ]] && export PATH=~/bin:$PATH

[[ -a ~/.bashrc.local ]] && source ~/.bashrc.local
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

__git_ps1() {
  local exit=$?
  local printf_format=" [%s]"

  local repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
    --is-bare-repository --is-inside-work-tree \
    --short HEAD 2>/dev/null)"
  local rev_parse_exit_code="$?"

  if [ -z "$repo_info" ]; then
    return $exit
  fi

  local short_sha=""
  if [ "$rev_parse_exit_code" == "0" ]; then
    short_sha="${repo_info##*$'\n'}"
    repo_info="${repo_info%$'\n'*}"
  fi

  git check-ignore -q . && exit $exit

  local branch
  branch=`git describe --contains --all HEAD 2>/dev/null` || branch="$short_sha"

  local w=""
  local i=""
  local u=""

  git diff --no-ext-diff --quiet || w="*"
  git diff --no-ext-diff --cached --quiet || i="+"
  git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>/dev/null && u="%"

  local gitstring="$branch $w$i$u"
  if [ "$w$i$u" == "" ]; then
    gitstring="$branch"
  fi

  printf -- "$printf_format" "$gitstring"
  return $exit
}

PS1="\$(__exit_status)$HOST_NAME\W\$(__git_ps1) \$ "
export PS1

# Better ls
alias ls="eza --icons=auto --hyperlink=auto"

# Detailed listing
alias ll="eza -lh --icons --git --hyperlink=auto"

# Detailed listing including hidden files
alias la="eza -lah --icons=auto --git --hyperlink=auto"

# Tree view
alias tree="eza --tree --icons=auto --hyperlink=auto"

# Reuse ls completions for eza (avoids defining a separate completion function)
compdef eza=ls

# Better cat
# alias cat="bat"

# =========================================================
# Core utilities
# =========================================================

alias grep="grep --color=auto"  # not aliased to rg: its flags differ (e.g. rg -r is --replace)
alias diff="diff --color=auto"
alias df="df -h"
alias rg="rg --hyperlink-format=kitty"

# =========================================================
# Kittens
# =========================================================

alias kssh="kitten ssh"
alias icat="kitten icat"
alias kpbcopy="kitten clipboard"
alias kpbpaste="kitten clipboard -g"

# =========================================================
# Editor
# =========================================================

alias vim="nvim"
alias gvim="neovide"

# =========================================================
# Git
# =========================================================

alias ga="git add"
alias gaa="git add -A"
alias gb="git branch"
alias gc="git commit"
alias gco="git checkout"
alias gd="git diff"
alias gl="git pull"
alias glog="git log --oneline"
alias gp="git push"
alias gst="git status"

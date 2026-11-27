# Better ls
alias ls="eza --icons auto"

# Detailed listing
alias ll="eza -lh --icons --git"

# Detailed listing including hidden files
alias la="eza -lah --icons auto --git"

# Tree view
alias tree="eza --tree --icons auto"

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

# =========================================================
# Editor
# =========================================================

alias vim="nvim"
alias gvim="neovide"

# =========================================================
# Git
# =========================================================

alias gaa="git add -A"
alias gb="git branch"
alias gc="git commit"
alias gco="git checkout"
alias gd="git diff"
alias gl="git pull"
alias glog="git log --oneline"
alias gp="git push"
alias gst="git status"

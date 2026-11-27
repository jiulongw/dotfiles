ZSH_STATE_DIR="$HOME/.local/state/zsh"
ZSH_CACHE_DIR="$HOME/.cache/zsh"

mkdir -p "$ZSH_STATE_DIR"
mkdir -p "$ZSH_CACHE_DIR"

typeset -aU path

# =========================================================
# History
# =========================================================

HISTFILE="$ZSH_STATE_DIR/history"
HISTSIZE=100000
SAVEHIST=100000

setopt SHARE_HISTORY  # implies appending, so APPEND_HISTORY isn't needed
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_VERIFY         # show !!/!$ expansions for review instead of running them immediately
setopt HIST_REDUCE_BLANKS  # strip superfluous whitespace before saving
setopt EXTENDED_HISTORY    # record timestamp + duration (see: history -i)

# =========================================================
# Shell behaviour
# =========================================================

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1

# GPG pinentry needs the current tty (interactive shells only, so it lives here not .zshenv)
export GPG_TTY=$TTY

# =========================================================
# Completion
# =========================================================

# Load completion system
autoload -Uz compinit

# Initialize completion with cached metadata file
# (dir must exist, otherwise the dump is never written and compinit rescans every startup)
compinit -d "$ZSH_CACHE_DIR/zcompdump"

# Include dotfiles in completion without having to type the leading "."
_comp_options+=(globdots)

# Enable interactive completion menu selection
zstyle ':completion:*' menu select

# Make completion case-insensitive
# Example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # lowercase input matches upper and lower

# Colour completion lists like ls (falls back to zsh's default colours when LS_COLORS is unset)
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# =========================================================
# Functions
# =========================================================

source_if_exists() {
  if [[ -f "$1" && -r "$1" ]]; then
    source "$1"
  fi
}

export_if_exists() {
  if [[ -e "$2" ]]; then
    export "$1=$2"
  fi
}

prepend_path() {
  # prepend path if directory exists, and the path is not in the $path array.
  # this is to prevent unexpectedly change the order of $path when zsh is nested (such as in tmux).
  if [[ -d $1 && -z $path[(r)$1] ]]; then
    path=($1 $path)
  fi
}

append_path() {
  # append path if directory exists, we don't need to worry adding path twice,
  # because `typeset -aU path` in the very beginning will do that for us.
  if [[ -d $1 ]]; then
    path+=($1)
  fi
}

# =========================================================
# Paths
# =========================================================

prepend_path "$HOME/.local/bin"
prepend_path "/opt/homebrew/bin"
prepend_path "/opt/nvim-linux-arm64/bin"

# =========================================================
# Smart directory navigation
# =========================================================

# Initialize zoxide (must come after compinit so its `z` completions get registered)
if which zoxide > /dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# =========================================================
# Fuzzy finder
# =========================================================

if which fzf > /dev/null 2>&1; then
  source <(fzf --zsh)
fi

# =========================================================
# Editor
# =========================================================

if which nvim > /dev/null 2>&1; then
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

# =========================================================
# Modular Config Files
# =========================================================

# fzf configuration
source "$ZDOTDIR/fzf.zsh"

# Aliases
source "$ZDOTDIR/aliases.zsh"

# Custom keybindings
source "$ZDOTDIR/bindings.zsh"

# Plugins and plugin manager
source "$ZDOTDIR/plugins.zsh"

# Prompt/theme
source "$ZDOTDIR/prompt.zsh"

# Toolchains
source "$ZDOTDIR/toolchains.zsh"

# =========================================================
# User Custom Configurations
# =========================================================

source_if_exists "$ZDOTDIR/local.zsh"

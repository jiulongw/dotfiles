# Cursor shape per vi mode
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

# Disable command mode line highlight
ZVM_VI_HIGHLIGHT_BACKGROUND=none
ZVM_VI_HIGHLIGHT_FOREGROUND=none
ZVM_VI_HIGHLIGHT_EXTRASTYLE=none

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# zsh-vi-mode resets all bindings on init, so custom bindings
# must be registered via this hook to survive.
zvm_after_init() {
  # Option+Right -> move forward one word
  bindkey '^[[1;3C' forward-word

  # Option+Left -> move backward one word
  bindkey '^[[1;3D' backward-word

  # Ctrl+F -> fzf file picker (no hidden files)
  bindkey '^F' _fzf_file_no_hidden

  # Ctrl+\ -> toggle autosuggestions (useful for screen recordings)
  # bindkey '^\' autosuggest-toggle

  # Up/Down -> history search by prefix
  for prefix in '\e[' '\eO'; do
    bindkey "${prefix}A" up-line-or-beginning-search
    bindkey "${prefix}B" down-line-or-beginning-search
  done

  # Only overwrite Ctrl+R if fzf is installed and its widgets are loaded
  if zle -l | grep -q fzf-history-widget; then
    # Bind fzf specifically to the vi-insert mode (-M viins)
    bindkey -M viins '^R' fzf-history-widget
  fi
}

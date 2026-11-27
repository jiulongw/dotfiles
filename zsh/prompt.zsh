# Prevent Python virtualenv from polluting the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

export_if_exists STARSHIP_CONFIG "$ZDOTDIR/starship.toml"

FUNCNEST=100

eval "$(starship init zsh)"

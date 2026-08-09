export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="$HOME/.local/bin:$PATH"

# Modern CLI Tools Setup

# eza (modern ls replacement)
if command -v eza &>/dev/null; then
  alias ls="eza --icons=auto"
  alias l="eza -lbF --icons=auto"
  alias ll="eza -lbgl --icons=auto"
  alias la="eza -lbhHigUmuSa --icons=auto"
  alias lt="eza --tree --level=2 --icons=auto"
fi

# bat (modern cat replacement)
if command -v bat &>/dev/null; then
  alias cat="bat --paging=never"
  export PAGER="less -R"
  export BAT_THEME="Catppuccin Mocha"
fi

# zoxide (smarter cd command)
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

# fzf (fuzzy finder with fd integration)
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
  if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
  fi
fi
# Starship Prompt (Catppuccin Mocha Powerline)
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

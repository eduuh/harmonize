export GIT_EDITOR=nvim

# Key bindings
bindkey -v
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Aliases
alias nav='cd "$(find . -type d | fzf)"'
alias gdel='git branch | grep -v "main" | xargs git branch -D'
alias cat='bat'
alias ls='ls -la --color'
alias zz='z -'

# Unset NODE_OPTIONS to avoid conflicts
unset NODE_OPTIONS

# NVM (Node Version Manager) setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Bun setup
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Azure auth path (if applicable)
export PATH="${PATH}:/mnt/c/Users/edwinmuraya/AppData/Local/Programs/AzureAuth/0.9.1"
export PATH="${PATH}:/mnt/c/Windows/System32:/mnt/c/Windows:/mnt/c/Windows/System32/WindowsPowerShell/v1.0"

# Byte Safari tools path (if applicable)
export PATH="${PATH}:~/projects/byte_safari/tools/bash/"

# Envman setup (if applicable)
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Zoxide setup (for fast directory navigation)
eval "$(zoxide init zsh)"

# Cross-platform configuration (for macOS)
if [[ "$(uname)" == "Darwin" ]]; then
  # PNPM setup
  export PNPM_HOME="/Users/edwinmuraya/Library/pnpm"
  [[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"
  
  # NVM setup for macOS (ensure it's loaded from Homebrew)
  if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
    . "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
  fi

  # ARM GCC setup (specific to macOS/ARM)
  export PATH="/opt/homebrew/opt/arm-none-eabi-gcc@8/bin:$PATH"
fi

# Starship prompt initialization
eval "$(starship init zsh)"
export PATH=$HOME/.local/bin:$PATH
ensure_tmux_is_running() {
  if [[ -z "$TMUX" ]]; then
     $HOME/.bin/tat.sh
  fi
}

ensure_tmux_is_running

pit() {
  case "$1" in
    path)
      export ACTIVE_PATH="$HOME/projects/1JS/midgard/packages/people-in-taskbar"
      echo "ACTIVE_PATH set to $ACTIVE_PATH"
      ;;
    restart)
      ~/projects/work/script/restart-app people
      ;;
    fit)
      export ACTIVE_PATH="$HOME/projects/1JS/midgard/packages/files-in-taskbar"
      echo "ACTIVE_PATH set to $ACTIVE_PATH"
      ;;
    cit)
      export ACTIVE_PATH="$HOME/projects/1JS/midgard/packages/calendar-in-taskbar"
      echo "ACTIVE_PATH set to $ACTIVE_PATH"
      ;;
    *)
      cd "$HOME/projects/1JS/midgard/packages/people-in-taskbar" || echo "Directory does not exist"
      ;;
  esac
}

fit() {
  cd "$HOME/projects/1JS/midgard/packages/files-in-taskbar" || echo "Directory does not exist"
}

cit() {
  cd "$HOME/projects/1JS/midgard/packages/calendar-in-taskbar" || echo "Directory does not exist"
}

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

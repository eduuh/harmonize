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
      export ACTIVE_PATH="/home/eduuh/projects/1JS/midgard/packages/people-in-taskbar"
      echo "ACTIVE_PATH set to $ACTIVE_PATH"
      ;;
    restart)
      ~/projects/work/script/restart-app people
      ;;
    fit)
      Export ACTIVE_PATH="/home/eduuh/projects/1JS/midgard/packages/files-in-taskbar"
      echo "ACTIVE_PATH set to $ACTIVE_PATH"
      ;;
    cit)
      export ACTIVE_PATH="/home/eduuh/projects/1JS/midgard/packages/calendar-in-taskbar"
      echo "ACTIVE_PATH set to $ACTIVE_PATH"
      ;;
    *)
      cd /home/eduuh/projects/1JS/midgard/packages/people-in-taskbar/ || echo "Directory /workspaces/1JS/midgard/packages/people-in-taskbar does not exist"
      ;;
  esac
}

fit() {
  cd /home/eduuh/projects/1JS/midgard/packages/files-in-taskbar || echo "Directory /workspaces/1JS/midgard/packages/files-in-taskbar does not exist"
}

cit() {
  cd /home/eduuh/projects/1JS/midgard/packages/calendar-in-taskbar || echo "Directory /workspaces/1JS/midgard/packages/calendar-in-taskbar does not exist"
}

# Command to set or reset ACTIVE_PATH environment variable with help
ap() {
  if [[ "$1" == "help" ]]; then
    echo "Usage of ap:"
    echo "  ap <option>"
    echo "Options:"
    echo "  pit   - Set ACTIVE_PATH to /workspaces/1JS/midgard/packages/people-in-taskbar"
    echo "  fit   - Set ACTIVE_PATH to /workspaces/1JS/midgard/packages/files-in-taskbar"
    echo "  cit   - Set ACTIVE_PATH to /workspaces/1JS/midgard/packages/calendar-in-taskbar"
    echo "  -r    - Reset ACTIVE_PATH to an empty value"
    echo "  help  - Show this help message"
    return 0
  elif [[ "$1" == "-r" ]]; then
    unset ACTIVE_PATH
    echo "ACTIVE_PATH has been reset"
    return 0
  fi

  # Handle setting ACTIVE_PATH using case statement
  case "$1" in
    pit)
      export ACTIVE_PATH="/home/eduuh/projects/1JS/midgard/packages/people-in-taskbar"
      echo "ACTIVE_PATH set to $ACTIVE_PATH"
      ;;
    fit)
      Export ACTIVE_PATH="/home/eduuh/projects/1JS/midgard/packages/files-in-taskbar"
      echo "ACTIVE_PATH set to $ACTIVE_PATH"
      ;;
    cit)
      export ACTIVE_PATH="/home/eduuh/projects/1JS/midgard/packages/calendar-in-taskbar"
      echo "ACTIVE_PATH set to $ACTIVE_PATH"
      ;;
    *)
      echo "Unknown option: $1"
      return 1
      ;;
  esac
}


# pnpm
export PNPM_HOME="/home/eduuh/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

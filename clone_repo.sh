
#!/bin/zsh

clone_repositories() {
  cd ~
  
  if [ ! -d ~/projects ]; then
    mkdir ~/projects
  fi

  REPOSITORIES=(
    "git@github.com:eduuh/byte_safari.git"
    "git@github.com:eduuh/keyboard.git"
    "git@github.com:eduuh/homelab.git"
    "git@github.com:eduuh/nvim.git"
    "git@github.com:eduuh/dotfiles.git"
  )

  if [ "$CODESPACES" = "true" ]; then
      REPOSITORIES=(
          "https://github.com/eduuh/nvim.git"
          "https://github.com/eduuh/dotfiles.git"
      )
  fi
    
  for REPO in "${REPOSITORIES[@]}"; do
      REPO_NAME=$(basename "$REPO" .git)
      TARGET_DIR=~/projects/"$REPO_NAME"

      if [[ "$REPO_NAME" == "nvim" ]]; then
          if [ ! -d "$TARGET_DIR" ]; then
              echo "Cloning $REPO_NAME into $TARGET_DIR..."
              git clone "$REPO" "$TARGET_DIR"
          fi
          
          echo "Creating symbolic link for $REPO_NAME at ~/.config/nvim..."
          sudo ln -sf "$TARGET_DIR" ~/.config/nvim
      else
          if [ -d "$TARGET_DIR" ]; then
              echo "Skipping $REPO_NAME: Already exists at $TARGET_DIR."
          else
              echo "Cloning $REPO_NAME into $TARGET_DIR..."
              git clone "$REPO" "$TARGET_DIR"
          fi
      fi
  done
}

clone_repositories

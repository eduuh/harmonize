#!/bin/bash
not_in_tmux() {
  [ -z "$TMUX" ]
}

DIR=$1

# If no arguments are passed in try to immediately attach or start without further input
echo "$DIR"
if [ -z "$DIR" ]; then
  if not_in_tmux; then
    tmux attach && exit 1 || DIR="--start"
  else
    exit 1
  fi
fi

# If --start was passed in immediately start a new session based on the current directory
if [ "$DIR" == "--start" ]; then
  echo "starting"
  path_name="$(basename "$PWD")"
  session_name=${path_name}
else
  active_sessions=$(tmux list-sessions -F "#S")

  # Gather directories in the current directory
  directories=$(cd "$DIR" && ls -d */ | sed "s|/||g")

  # Combine directories and active tmux sessions, ensuring they are distinct
  combined_list=$(echo -e "$directories\n$active_sessions" | sort -u)

  # Use fzf to select the project/session, showing both directories and tmux sessions
  _session_name=$(echo "$combined_list" | fzf --reverse --header="Select project/session from $(basename "$DIR") >")

  # Replace dots with underscores in the selected session name
  session_name=${_session_name//./_}

  # Construct the full path to the selected session or project
  path_name="$DIR/$_session_name"
fi

echo session name is \""$session_name"\"
echo path name is "$path_name"

if [ -z "$session_name" ]; then
  # operation cancelled by user
  exit 1
fi

session_exists() {
  # checks if the $session_name exists
  tmux has-session -t "=$session_name"
}

create_detached_session() {
  if [ "$DIR" == "--start" ]; then
    (
      TMUX=''
      tmux new-session -Ad -s "$session_name" -c "$path_name"
    )
  else
    (
      TMUX=''
      tmux new-session -Ad -s "$session_name" -c "$path_name"
    )
  fi
}

create_if_needed_and_attach() {
  if not_in_tmux; then
    tmux new-session -As "$session_name" -c "$path_name"
  else
    if ! session_exists; then
      create_detached_session
    fi
    tmux switch-client -t "$session_name"
  fi
}

attatch_to_first_session() {
  tmux attach -t "$(tmux list-sessions -F "${session_name}" | head -n 1)"
  tmux choose-tree -Za
}

create_if_needed_and_attach || attatch_to_first_session

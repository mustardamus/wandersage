function run_terminal_command() {
  local cmd="$1"
  local label="$2"
  local check_char="$(dump_last_char)"
  
  focus_terminal
  type_on_focused_pane "$cmd"

  while [ true ]; do
    if [ "$(has_prompt $check_char)" = "true" ]; then
      break
    fi

    print_spinner "Waiting for command prompt"
  done

  focus_notebook
}

function run_terminal_commands() {
  local block="$1"

  while IFS= read -r cmd; do
    if [ ! -z "$cmd" ]; then
      run_terminal_command "$cmd"
    fi
  done <<< "$(echo -e $block)"
}

function run_notebook_code() {
  local block="$1"
  local type="$2"
  local interpreters="$3"
  local interpreter="$(find_binary_path "$interpreters")"

  if [ -z "$interpreter" ]; then
    print_error "Could not find a interpreter for '$type'. Looked for '$interpreters'."
    return
  fi

  local tmp="$(mktemp)"
  local pwd="$(pwd)"

  echo -e "$(trim "$block")" > "$tmp"
  cd $NOTEBOOKS

  if [ "$type" = "shell" ] || [ "$type" = "bash" ]; then
    source "$tmp"
  else
    "$interpreter" "$tmp"
  fi

  rm "$tmp"
  cd "$pwd"
}

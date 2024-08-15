function handle_code_terminal() {
  local block="$1"
  local type="$2"
  local message=""
  local num="$(echo -e "$(trim "$block")" | wc -l)"

  if [ "$type" = "shell" ]; then
    if [ "$num" = "1" ]; then
      message="Run shell command in terminal?"
    else
      message="Run $num shell commands in terminal?"
    fi
  else
    message="Send $type code to terminal?"
  fi

  print_code "$block" "$type"

  if [ "$OPT_NO_CONFIRM" = "true" ]; then
    run_terminal_commands "$block"
  else
    $GUM confirm "$message" && run_terminal_commands "$block"
  fi
}

function handle_code_notebook() {
  local block="$1"
  local type="$2"

  if [ "$OPT_NOTEBOOK_CODE_ALLOWED" = "false" ]; then
    print_in_borders "Inline code blocked per user request." 11
    return
  fi

  case "$type" in
    "shell"|"bash")
      run_notebook_code "$block" "bash" "bash"
    ;;
    "python")
      run_notebook_code "$block" "python" "python python3 python3.5 python3.11"
    ;;
    "javascript"|"js")
      run_notebook_code "$block" "javascript" "node deno bun"
    ;;
    "typescript"|"ts")
      run_notebook_code "$block" "typescript" "deno bun"
    ;;
    "perl")
      run_notebook_code "$block" "perl" "perl"
    ;;
    *) print_error "Don't know how to run '$type'." ;;
  esac
}

function handle_code() {
  local block="$1"
  local def="$2"
  local type="$(get_code_block_part "$def" "type")"
  local target="$(get_code_block_part "$def" "target")"
  
  if [ -z "$target" ]; then
    print_code "$block" "$type"
  else
    case "$target" in
      "terminal") handle_code_terminal "$block" "$type" ;;
      "notebook") handle_code_notebook "$block" "$type" ;;
      *) print_error "Unknown code target '$target'"
    esac
  fi
}

function handle_line() {
  local line="$1"

  if [ "${line:0:2}" = "# " ]; then
    title="${line:2:${#line}-2}"
    
    set_notebook_name "$title"
  fi
}

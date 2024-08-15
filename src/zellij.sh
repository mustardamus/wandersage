function set_notebook_name() {
  local name="$1"

  $ZEL action rename-pane "$name"
}

function focus_terminal() {
  $ZEL action focus-next-pane
  $ZEL action switch-mode locked
}

function focus_notebook() {
  # TODO more reliable way
  # focus-next-pane, dump layout, is "Terminal" focused?
  $ZEL action switch-mode normal
  $ZEL action focus-previous-pane
}

function type_on_focused_pane() {
  local cmd="$1"

  while read -n1 char; do
    if [ -z "$char" ]; then
      char=" " # replace back empty with space
    fi

    $ZEL action write-chars "$char"
    sleep 0.003
  done <<< "$(echo -n "$cmd")"

  $ZEL action write 13 # return
}

function dump_screen() {
  local tmp="$(mktemp)"

  $ZEL action dump-screen "$tmp"
  content="$(cat $tmp)"
  rm "$tmp"
  echo "$content"
}

function dump_last_char() {
  local screen="$(dump_screen)"
  local line="$(get_last_line "$screen")"

  echo "$(get_last_char "$line")"
}

function has_prompt() {
  local check_char="$1"
  local char="$(dump_last_char)"

  case "$char" in
    "$check_char" | "#" | "\$" | ">") echo "true" ;;
    *) echo "false" ;;
  esac
}

function load_notebook() {
  local notebook="$1"
  local content="$(cat $notebook)"

  export NOTEBOOK="$(realpath $notebook)"
  export NOTEBOOKS="$(dirname $notebook)"

  set_notebook_name "Notebook"
  clear
  focus_terminal
  type_on_focused_pane "clear"
  focus_notebook
  notebook_code_warning "$content"

  for i in {1..20}; do
    # since the interactiveness, sleep and send a bunch of scroll-ups to make
    # sure we are at the top of the notebook in the background
    eval "sleep 2 && $ZEL action page-scroll-up &> /dev/null" &
  done

  parse "$content" "handle_code" "print_markdown" "handle_line"

  if [ -d "$NOTEBOOKS" ]; then
    echo
    echo
    notebooks_explorer
  fi
}

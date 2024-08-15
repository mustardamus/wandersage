function init() {
  if [ -z "$NOTEBOOK" ]; then
    load_notebook "$ROOT_PATH/docs/01-intro.md"
  else
    if [ -f "$NOTEBOOK" ]; then
      load_notebook "$NOTEBOOK"
    elif [ -d "$NOTEBOOK" ]; then
      export NOTEBOOKS="$NOTEBOOK"
      notebooks_explorer
    else
      print_error "'$NOTEBOOK' does not exist."
    fi
  fi
}

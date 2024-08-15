function notebooks_explorer() {
  local choices=""
  local selected=""
  local selected_switch=""
  local md_count="$(find $NOTEBOOKS -maxdepth 1 -type f -name '*.md' -printf x | wc -c)"

  if [ "$md_count" = "1" ]; then
    return
  fi

  for notebook in $NOTEBOOKS/*.md; do
    notebook_file="$(basename $notebook)"
    first_line="$(cat "$notebook" | head -1)"
    title=""

    if [ "${first_line:0:2}" = "# " ]; then
      title="${first_line:2:${#first_line}-2}"
    fi

    if [ -z "$title" ]; then
      entry="[$notebook_file]"
    else
      entry="$title $(echo "[$notebook_file]" | $GUM style --foreground 8)"
    fi

    if [ "$selected_switch" = "true" ] && [ -z "$selected" ]; then
      selected="$entry"
    fi

    if [ "$(realpath $notebook)" = "$NOTEBOOK" ]; then
      selected_switch="true"
      entry="$(echo "$entry" | $GUM style --foreground 8)"
    fi

    choices="$choices\n$entry"
  done

  height=$(($md_count + 2))

  if [ "$height" -gt "12" ]; then
    height="12"
  fi

  header="Load next notebook in '$NOTEBOOKS':"
  choice="$(echo -e "$(trim "$choices")" | $GUM choose --selected "$selected" --header "$header" --height "$height")"
  notebook="$(echo "$choice" | awk -F'[][]' '{print $2}')"

  load_notebook "$NOTEBOOKS/$notebook"
}

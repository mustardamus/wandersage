function notebook_code_warning_callback() {
  local block="$1"
  local def="$2"
  local type="$(get_code_block_part "$def" "type")"
  local target="$(get_code_block_part "$def" "target")"
  
  if [ "$target" = "notebook" ]; then
    print_code "$block" "$type"
  fi
}

function notebook_code_warning() {
  local content="$1"

  if [ "$OPT_NO_WARN" = "true" ]; then  
    export OPT_NOTEBOOK_CODE_ALLOWED="true"
    return
  fi

  code_blocks="$(parse "$content" "notebook_code_warning_callback")"

  if [ ! -z "$code_blocks" ]; then
    echo "$code_blocks"

    print_in_borders "This notebook contains inline code (shown above). Please review it! You can skip this warning by passing '--no-warn' as a command line argument." \
      11 "Warning" 1

    $GUM confirm \
      --prompt.foreground 11 \
      --selected.background 11 \
      --selected.foreground 0 \
      "Execute inline code without further confirmation?" && \
        export OPT_NOTEBOOK_CODE_ALLOWED="true" || \
        export OPT_NOTEBOOK_CODE_ALLOWED="false"
    
    clear
  fi
}

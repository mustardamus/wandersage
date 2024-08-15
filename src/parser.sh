function parse() {
  local content="$1"
  local code_block_callback="$2"
  local markdown_callback="$3"
  local line_callback="$4"
  local block=""
  local is_code_block_open="false"
  local code_block=""
  local code_block_def=""

  while IFS= read -r line; do
    if [ "${line:0:3}" = "\`\`\`" ]; then
      if [ "$is_code_block_open" = "false" ]; then
        is_code_block_open="true"
        code_block_def="$line"
      else
        if [ ! -z "$markdown_callback" ]; then
          $markdown_callback "$block"
        fi

        if [ ! -z "$code_block_callback" ]; then
          $code_block_callback "$code_block" "$code_block_def"
        fi

        is_code_block_open="false"
        block=""
        code_block=""
        code_block_def=""
      fi
    else # not a open or close code block
      if [ "$is_code_block_open" = "false" ]; then
        if [ ! -z "$line_callback" ]; then
          $line_callback "$line"
        fi

        block="$block\n$line"
      else
        code_block="$code_block\n$line"
      fi
    fi
  done <<< "$content"

  if [ ! -z "$block" ] && [ ! -z "$markdown_callback" ]; then
    $markdown_callback "$block"
  fi
}


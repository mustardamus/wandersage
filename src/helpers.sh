function is_script_sourced {
  # determines if script is sourced by another one, or run from the command line
  ! (return 0 2>/dev/null)
}

function trim(){
	local str="$1"

	str="$(printf "$str" | sed -z 's/^[[:space:]]*//')"
	str="$(printf "$str" | sed -z 's/[[:space:]]*$//')"

	echo "$str"
}

function get_command_label() {
  local block="$1"
  local label="commands"
  local num="$(echo -e "$(trim "$block")" | wc -l)"

  if [ "$num" = "1" ]; then
    label="command"
  fi

	echo "$label"
}

function get_last_char() {
  local str="$1"

  echo "${str:${#str}-1:1}"
}

function get_last_line() {
  local str="$1"
  local line="$(echo $str | tail -1)"

  echo "$(trim "$line")"
}

function find_binary_path() {
  local binaries="$1"
  local path=""

  for binary in $binaries; do
    if [ -x "$(command -v "$binary")" ]; then
      path="$(command -v "$binary")"
      break
    fi
  done

  echo "$path"
}

function get_code_block_part() {
  local line="$1"
  local part="$2"
  local def="$(trim "${line:3:${#line}-3}")" # remove leading ```
  local def_arr=(${def//:/ })
  local index=0

  case "$part" in
    type) index=0 ;;
    target) index=1 ;;
  esac

  echo "$(trim "${def_arr[$index]}")"
}

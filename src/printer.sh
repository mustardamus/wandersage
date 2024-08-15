function print_markdown() {
  local block="$(trim "$1")"

  if [ ! -z "$block" ]; then
    local width="$(tput cols)"
    local md="$(echo -e "$block" | $GUM format -t markdown)"

    echo
    echo -e "$(trim "$md")" | $GUM style --width "$width"
  fi
}

function print_in_borders() {
  local content="$1"
  local border_color="$2"
  local label="$3"
  local padding_lr="$4"
  local term_width="$(tput cols)"
  local width="$(($term_width - 2))"

  if [ -z "$border_color" ]; then
    border_color=8
  fi

  if [ -z "$padding_lr" ]; then
    padding_lr="0"
  fi

  echo "$(trim "$content")" | $GUM style \
    --width $width \
    --border normal \
    --border-foreground $border_color \
    --padding "0 $padding_lr"
  
  if [ ! -z "$label" ]; then
    tput cuu 1 # cursor up one line
    echo "└─ $label " | $GUM style --foreground $border_color
  fi

  echo
}

function print_code() {
  local block="$1"
  local type="$2"
  local code=""
  local border_color=8

  if [ -z "$type" ]; then
    code="$(echo -e "$block" | $GUM format -t code)"
  else
    code="$(echo -e "$block" | $GUM format -t code -l $type)"
  fi

  print_in_borders "$code" "$border_color" "$type"
}

function print_spinner() {
  local title="$1"
  
  $GUM spin -a right --spinner pulse --title " $title" -- sleep 1
}

function print_error() {
  local msg="$1"

  print_in_borders "$msg" 9 "Error"
}

function print_error_argument() {
  local arg="$1"

  print_error "Unknown argument '$arg'. Pass '--help' to show possible arguments."
}

function print_help() {
  local help=`cat <<END
Wandersage 0.0.1 - A interactive notebook for the terminal
  https://github.com/mustardamus/wandersage

Usage:
  ./wandersage [OPTIONS] Notebooks Folder / Notebook File

Options:
  --help       - Show this help
  --no-warn    - Don't show initial warning if notebook has inline commands/code
  --no-confirm - Don't ask for confirmation before sending text to the terminal

Documentation:
  For an interactive documentation, execute Wandersage without any arguments.

Examples:
  ./wandersage                       # show the documentation
  ./wandersage docs/01-intro.md      # run a specific notebook
  ./wandersage docs/                 # show notebook explorer for folder
  ./wandersage --no-warn notebook.md # don't warn about inline commands/code
  ./wandersafe --no-confirm noteb.md # don't ask confirmation to send to terminal
END
`

  echo "$help"
}

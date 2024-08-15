# Reference

## Variables

### `$GUM`

The full path of the downloaded [Gum](https://github.com/charmbracelet/gum) binary.
You can use it via `bash` inline code to do all kinds of things: request user input, format text, render markdown, etc.

### `$ZEL`

The full path of the downloaded [Zellij](https://zellij.dev) binary.
You could use it, for example, to send [actions](https://zellij.dev/documentation/cli-actions) to the current Zellij session.

### `$NOTEBOOK`

The full path of the currently loaded notebook.

### `$NOTEBOOKS`

The full path of the parent directory of the currently loaded notebook.

## Functions

### `run_terminal_command` (src/execute.sh)

Focuses the interactive terminal pane, sends the string via simulated key strokes, followed by a return to execute it. Once the prompt is available again, the notebook pane is focused.

#### Arguments

- `command`: string of command to execute

```bash
run_terminal_command "echo 'Hello from the terminal!'"
```

### `run_terminal_commands` (src/execute.sh)

Runs multiple commands, separated by a new line, with `run_terminal_command`.

#### Arguments

- `commands`: string of commands to execute, separated by a new line

```bash
run_terminal_commands "echo 1\necho 2"
```

### `run_notebook_code` (src/execute.sh)

Finds a path of an installed interpreter, and executes code with it. If the language is `bash`, it is executed with the context of the notebook renderer, i.e. variables and functions you see here are available to your script.

If no interpreter is found, a error message is shown.

#### Arguments

- `code`: string of code block to run
- `language`: string of the language of the code
- `interpreters`: string of one or more interpreters to check if installed and used to execute the `code`, separated by space

```bash
run_notebook_code "echo $NOTEBOOK" "bash" "bash"
run_notebook_code "print('Hello from Python!')" "python" "python3 python"
```

### `trim` (src/helpers.sh)

Trims whitespace and line-breaks from the start and end of a string, and prints it.

#### Arguments

- `str`: the string to be trimmed

```bash
str="$(trim "   I am clean!   ")"
echo $str # -> "I am clean!"
```

### `get_last_char` (src/helpers.sh)

Gets the last character of a string and prints it.

#### Arguments

- `str`: the string to get the last character from

```bash
str="$(get_last_char "Hi!")"
echo $str # -> "!"
```

### `get_last_line` (src/helpers.sh)

Gets the last line in a multiline string, trims it, and prints it.

#### Arguments

- `str`: the string to get the last line from

```bash
str="$(get_last_line " 1   \n   2 ")"
echo $str # -> "2"
```

### `find_binary_path` (src/helpers.sh)

Find the first binary that exists in `$PATH` from a space separated string, and prints it.

#### Arguments

- `binaries`: string of space seprated binary names

```bash
path="$(find_binary_path "python python3")"
echo $path # -> "/usr/bin/python3"
```

### `load_notebook` (src/notebook.sh)

Load a notebook markdown file into the notebook pane and clears the interactive terminal. Sets the variables `$NOTEBOOK` and `$NOTEBOOKS`.

#### Arguments

- `notebook`: the abslolute or relative path of the notebook markdown file to load

```bash
load_notebook "path/to/notebook.md"
echo $NOTEBOOK  # -> "/full/path/to/notebook.md"
echo $NOTEBOOKS # -> "/full/path/to"
```

### `print_markdown` (src/printer.sh)

Renders and prints markdown. Formats it to fit the width of the terminal.

#### Arguments

- `markdown`: string of markdown to render

```bash
md="$(print_markdown "# Hi!")"
echo $md # -> [Heading 1] "Hi!"
```

### `print_in_borders` (src/printer.sh)

Prints a message in borders, optionally with a different color, a label and a left/right padding.

#### Arguments

- `message`: string to put in borders
- `color` (optional): number of the color to use, `8` (grey) by default [256 colors cheat sheet](https://www.ditig.com/publications/256-colors-cheat-sheet)
- `label` (optional): a label to put on the lower border
- `padding` (optional): number of charcacters for left/right padding inside the borders, default is `0`

```bash
just_border="$(print_in_borders "Hi!")"
alt_border="$(print_in_borders "Hi!" 12 "From Sky" 2)"

echo $just_border # -> [Gray borders] "Hi!"
echo $alt_border  # -> [Blue borders, label "From Sky", 2 padding] "Hi!"
```

### `print_code` (src/printer.sh)

Highlights code and prints it in borders.

#### Arguments

- `code`: string of code to highlight
- `language` (optional): string of language to use for highlighting and as label on lower border

```bash
bash="$(print_code "echo 'Hi!'")"
python="$(print_code "print('Hi!')" "python")"

echo $bash   # -> [generic highlight] "echo 'Hi!'"
echo $python # -> [python highlight with label] "print('Hi!')"
```

### `print_spinner` (src/printer.sh)

Prints a `pulse` spinner for one second.

#### Arguments

- `title`: string of spinner title

```bash
print_spinner "Hold on..."
```

### `print_error` (src/printer.sh)

Prints a message in red borders with "Error" label.

#### Arguments

```bash
print_error "Oh no!"
```

### `set_notebook_name` (src/zellij.sh)

Renames the currently focused pane.

#### Arguments

- `name` - string of the name to set

```bash
set_notebook_name "Title of the notebook"
```

### `focus_terminal` (src/zellij.sh)

Focuses the interactive terminal pane.

```bash
focus_terminal
```

### `focus_notebook` (src/zellij.sh)

Focuses the notebook pane.

```bash
focus_notebook
```

### `type_on_focused_pane` (src/zellij.sh)

Sends string as simulated keystrokes and a return key to the focused pane.

#### Arguments

- `str`: string of the text to type

```bash
type_on_focused_pane "echo 'Hi!'"
```

### `dump_screen` (src/zellij.sh)

Dumps the screen content of the currently focused pane and prints it.

```bash
screen="$(dump_screen)"
echo $screen # -> [content of the focused pane]
```

### `dump_last_char` (src/zellij.sh)

Use `dump_screen` and prints the last character of the content.

```bash
char="$(dump_last_char)"
echo $char # -> "$"
```

### `has_prompt` (src/zellij.sh)

Determines if the currently focused pane has a awaiting prompt by dumping the content and check the last character for known prompt characters.

Known prompt characters are `#`, `$` and `>`.

Prints the string "true" of a awaiting prompt was found, otherwise it prints "false".

#### Arguments

- `check_char`: first character to check to indicate a command prompt

```bash
check_char="$(dump_last_char)"

if [ "$(has_prompt $check_char)" = "true" ]; then
  echo "Found awaiting prompt."
fi
```

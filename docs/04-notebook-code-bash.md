# Inline Notebook Code - Bash

## Introduction

By appending `:notebook` to a code block definition, the code is run with the appropriate interpreter. For example ` ```bash:notebook` or ` ```python:notebook`, etc.

Inline notebook code blocks are not printed, but executed. After the execution is finished, the notebook continues to render.

```bash
echo "Hello from inline bash code in the notebook!"
```

```bash:notebook
echo "Hello from inline bash code in the notebook!"
```

## User Confirmation

The inline code and a warning message is shown before the notebook starts to render. That way, the user is given the opportunity to review the code, before running it.

However, you can turn off this behavior by passing `--no-warn` as a command line argument:

```shell
# will run inline code in this notebook without a warning
./wandersage --no-warn docs/04-notebook-code-bash.md
```

## How it works

The `bash` code is written to a temporary file and then `source`ed into the current script, which is the notebook renderer. This makes the already defined functions and variables available to the inline code.

The temporary file is then deleted, and the notebook continues to render.

The current working directory is the directory of the currently loaded notebook:

```shell
echo "Current working directory: $(pwd)"
echo "Loaded notebook path: $NOTEBOOK"
```

```shell:notebook
echo "Current working directory: $(pwd)"
echo "Loaded notebook path: $NOTEBOOK"
```

Variables are also available in the terminal, but only the initial values.

```shell:terminal
echo "$NOTEBOOKS"
```

See the documentation notebook [Reference](./08-reference.md) for a full list of functions and variables you have access to.

## Example accessing functions and variables

First we read user input with Gum (the binary path is set in the variable `$GUM`), print back the input in the notebook, and run the command to print the input in the interactive terminal:

```bash
export user_input="$($GUM input --value 'Hi there!')"
print_in_borders "User input in notebook: $user_input"
run_terminal_command "echo 'User input in terminal: $user_input'"
```

```bash:notebook
export user_input="$($GUM input --value 'Hi there!')"
print_in_borders "User input in notebook: $user_input"
run_terminal_command "echo 'User input in terminal: $user_input'"
```

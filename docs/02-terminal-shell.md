# Terminal - Shell Commands

## Default code blocks

Markdown code blocks don't do anything by default, they are just highlighted and printed. For example this ` ```shell` code block:

```shell
echo "Hello, world!"
```

## Sending shell commands to the terminal

If you append `:terminal` to the code block definition, the shell command will be sent to the interactive terminal, after being approved by the user. For example, this ` ```shell:terminal` code block:

```shell:terminal
echo "Hello, world!"
```

## Long running commands

The interactive terminal is locked while the command is running, i.e. the command prompt is available again. For example:

```shell:terminal
sleep 3
echo "Wake up, Neo..."
```

## Turn off confirmations

Before any shell commands are run, as you've seen, the user is asked to confirm it. This is the default behavior for two reason:

- makes a step-by-step notebook, so the reader can follow what is happening
- security, so notebooks can't execute unreviewed commands

However, you can turn off this behavior by passing `--no-confirm` as a command line argument:

```shell
# will run commands in this notebook without confirmation
./wandersage --no-confirm docs/02-terminal-shell.md
```

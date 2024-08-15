# Terminal - REPL Example

You are not limited to just sending shell commands! Append `:terminal` to any code block, and it will be sent to the interactive terminal.

This way, you can interact with REPL's, Docker, or even remote shells over SSH.

The notebook must provide the commands to enter the REPL or other shell, and to return to the base shell, so the next notebook can work with it.

## Python REPL example

First we need to send the shell command to enter the Python REPL, which we guess are either at `python` or `python3`.

```shell:terminal
command -v python && python || python3
```

Now that we are inside the Python REPL, we send the code we want to execute with the markdown code block definition of ` ```python:terminal`. For this example, let's just print some text and exit the REPL:

```python:terminal
print("Hello, Python!")
exit()
```

## How it works

When sending a command to the interactive terminal, Wandersage somehow has to know when this command is finished, or if it entered a REPL (for example), to continue rendering the notebook.

First, the last (non-whitespace) character of the terminals content is extracted. It may be `$`, for example.

After the command is executed, the content of the terminal is dumped periodically, and the last character extracted.

It is checked against the first extracted character, if they match, the command is deemed finished.

Since the prompt character could change, when entering a REPL or another shell, it is also checked against these known characters: `#`, `$` and `>`. If one of them match, the command is deemed finished.

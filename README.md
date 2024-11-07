# Wandersage

A interactive notebook for the terminal, powered by Bash, [Zellij](https://zellij.dev) and [Gum](https://github.com/charmbracelet/gum).

[demo.webm](https://github.com/user-attachments/assets/0dd20673-5fdb-4f97-8b13-515f12bfafd5)

## Getting started

The fastest way to try out Wandersage, is by cloning the repo and just run it. This downloads the dependencies Zellij and Gum, and loads the interactive [documentation](./docs/):

```shell
git clone https://github.com/mustardamus/wandersage.git
cd wandersage
./wandersage
```

After learning about the features, write your own notebook and load it:

```shell
./wandersage path/to/my-notebook.md
```

## Features

### Bootstrapping dependencies for Linux and MacOS

Zellij and Gum binaries are downloaded to a local folder, no installation or `sudo` needed. Only depends on `bash`, `curl` and `tar`.

### Multiplexing

Fancy word for two terminals, side by side, provided by Zellij. On the left side we have the notebook, and on the right side we have the interactive terminal.

### Global scratchpad terminal

Since the interactive terminal is cleared with each notebook loaded, there is a global overlaying terminal for you to use.

### Markdown

Notebooks are written in Markdown, and rendered by Gum. Wandersage provides two extensions to code blocks:

- `:terminal` to send commands or code to the interactive terminal
- `:notebook` to execute inline code for extending the notebook rendering

### Interactive terminal

The notebook can interact with the terminal, by sending commands or code via simulated key strokes - just as you would type or copy/paste the content. Since it is a real terminal, it is possible to enter REPLs, Docker, or even remote shells via SSH.

### Confirmation for sending commands or code

Before sending commands or code to the interactive terminal, the user has to confirm it. This makes the notebook a nice step-by-step experience. It can be turned off with `--no-confirm`.

### Notebook inline code

Notebooks can be extended by inline code in Bash, JavaScript, TypeScript, Python and Perl. If Bash is used, the inline code has access to Wandersage's variables and functions. This way, for example, you could load additional resources or request user input.

### Inline code warning

If the loaded notebook has inline code, it is shown, along with a warning, before the notebook starts to render. This way, the user can review the code. It can be turned off with `--no-warn`.

### Notebooks explorer

If there are multiple `.md` notebook files in the same directory, a menu of all these files is shown at the end of each notebook.

### Interactive documentation

The documentation for Wandersage itself is a collection of interactive notebooks. Just run it without any arguments: `./wandersage`.

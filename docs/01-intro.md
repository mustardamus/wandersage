# Wandersage

A interactive and extendable notebook for the terminal.

Scroll up and down with `Alt+Up` and `Alt+Down`. `Ctrl+Q` to quit.

## Written in markdown

Notebooks are ordinary markdown `*.md` files which are rendered by [Gum](https://github.com/charmbracelet/gum), which gives you all the features you would expect: headings, lists, code highlighting, etc.

## Interactive terminal

Next to the notebook is the terminal. This multi-pane feature is provided by [Zellij](https://zellij.dev). It is interactive, which means you can send commands and code from the notebook via simulated keystrokes to it.

You can also use the terminal! Focus via `Alt+Right`, and back to the notebook with `Alt+Left`.

## Scratchpad terminal

The interactive terminal is cleared with each new notebook loaded. For a persistent terminal with your default shell, hit `Alt+S` to toggle the scratchpad.

## Inline notebook code

Notebooks can be extended by inserting scripting code (Bash, Python, JS, etc.) into the rendering process. That way, requesting additional input from the user or fetching remote data, for example, becomes possible.

## Notebooks explorer

Below you see the notebooks explorer. It is visible if other `*.md` files are in the same folder as the notebook that is currently loaded.

For convenience, the next notebook in the list is already selected. Just hit `Enter` to continue this documentation and dive deeper into the features.

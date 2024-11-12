# Changelog

## 0.2.1 - 2024-11-12

- Correctly set system or bootstrapped binaries path, `$ZEL` & `$GUM`
- Handle folders with no notebooks in it

## 0.2.0 - 2024-11-07

- Initally set `$NOTEBOOK` and `$NOTEBOOKS` variables for interactive terminal
- Fixed 'bad substition' confirmation bug
- Bootstrapping now works for Linux and MacOS, with downloading for the correct arch
- Set notebook name when notebook explorer is only shown

## 0.1.0 - 2024-08-15

Initial release. Booya!

- Bootstrapping Zellij & Gum dependencies
- Notebook and interactive terminal pane
- Global scratchpad terminal
- Markdown rendering
- Send commands/code to interactive terminal
- User confirmation for sending commands/code
- Execute inline code: Bash, JavaScript, TypeScript, Python, Perl
- Warning/confirmation for inline code
- Notebooks explorer
- Command line options: `--help`, `--no-confirm`, `--no-warn`
- Interactive documentation and demo

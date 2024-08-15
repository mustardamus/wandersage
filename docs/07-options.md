# Command Line Options

```shell
./wandersage [OPTIONS] Notebooks Folder / Notebook File
```

## Options

### `--help`

Show help text.

```shell
./wandersage --help
```

### `--no-confirm`

Turns off the confirmation for sending commands and code to the interactive terminal, so they are sent right away when rendering the notebook.

```shell
./wandersage --no-confirm notebook.md
```

### `--no-warn`

Turns off warning and confirmation for inline code, so it is executed right away when rendering the notebook.

```shell
./wandersage --no-warn notebook.md
```

## Notebooks Folder

If the last argument passed is a folder, the notebooks explorer is shown, which in turn will show all `.md` files in the folder. The user selects the notebook he wishes to view, and it is rendered.

```shell
./wandersage docs/
```

## Notebook File

If the last argument is a `.md` notebook file, it is rendered. If there are multiple `.md` files in the parent folder, the notebooks explorer is shown, with the next entry from the current `.md` notebook selected.

```shell
./wandersage docs/01-intro.md
```

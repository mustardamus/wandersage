# Inline Notebook Code - Others

## How it works

If the inline code is not `bash` or `shell`, but any other supported language, these steps are taken to execute the inline code:

- find path of one of the defined interpreters for the language
- show error message if no interpreter was found, or unknown language
- write code to a temporary file
- run temporary file with the interpreter
- delete temporary file
- continue to render the notebook

The current working directory is the directory of the currently loaded notebook:

```python
from pathlib import Path
print("Current working directory:", Path.cwd())
```

```python:notebook
from pathlib import Path
print("Current working directory:", Path.cwd())
```

## Supported Languages

| Code Block Definition | Interpreters                           |
| --------------------- | -------------------------------------- |
| bash, shell           | bash                                   |
| python                | python, python3, python3.5, python3.11 |
| javascript, js        | node, deno, bun                        |
| typescript, ts        | deno, bun                              |
| perl                  | perl                                   |

The first interpreter from the list, which is installed on the system, is used to run the inline code.

## Examples

### python

```python:notebook
print("Hello from Python!")
```

### javascript

```javascript:notebook
console.log("Hello from JavaScript!")
```

### typescript

```typescript:notebook
console.log("Hello from TypeScript!")
```

### perl

```perl:notebook
print("Hello from Perl!")
```

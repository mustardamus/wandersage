# Demo - Inline Code

We can make notebooks even more interactive by using inline code.

## Bash inline code

Using `bash`, we can tap into Wandersage's variables and functions:

```bash
user_input="$($GUM input --value 'Hi there!')"
print_in_borders "User input in notebook: $user_input"
```

```bash:notebook
user_input="$($GUM input --value 'Hi there!')"
print_in_borders "User input in notebook: $user_input"
```

## Other inline code

We can write inline code with `JavaScript`, `TypeScript`, `Python` and `Perl`, as long as a interpreter is installed on the system:

```python
print("Hello from Python!")
```

```python:notebook
print("Hello from Python!")
```

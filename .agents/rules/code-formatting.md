# Line spacing

1. Multiple line statements without comments should have one empty line before each of them, and one after each of them:

```python

a = {
    'value1': 10,
    'value2': 20,
}

b = {
    'value1': 100,
    'value2': 200,
}

c = {
    'value1': 1000,
    'value2': 2000,
}

```

# Comments

1. If comment is written for a single statement, it should be on the line preceeding it. The statement can be one, or multiline:

```python
# Comment for a single line single statement
a = {'value1': 10}

# Comment for a multi-line single statement
a = {
    'value1': 10,
    'value2': 20,
}

```

2. If the comment is written for a multiple statements, then it should have one empty line before the statements it covers. Same applied to to multiple line multiple statements, that all together have one comment:

```python
# Comment for a single line multiple statements

a = {'value1': 10}
b = {'value1': 100}

# Comment for a single line multiple statements

a = {'value1': 10}
b = {'value1': 100}

# Comment for a multi-line single multiple statements

a = {
    'value1': 10,
    'value2': 20,
}

b = {
    'value1': 100,
    'value2': 200,
}

```

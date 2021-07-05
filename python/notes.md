# Notes on Python

## doctests

`twice.py`:

```python
def twice(x):
    """
    >>> twice(0)
    0
    >>> twice(1.5)
    3.0
    >>> twice(3)
    6
    """
    return 2 * x
```

```bash
$ python -m doctest twice.py
```

## List Comprehensions

Carthesian product:

```python
>>> l = [x + y for x in [1,2,3]
               for y in [10,20,30]]
>>> l
[11,21,31,12,22,32,31,32,33]
```

The list is built as if the for loops were nested in the order they appear in
the list comprehension:

```python
l = []
for x in [1,2,3]:
    for y in [10,20,30]:
        l.append(x+y)
```

## Generator Expressions

Like list comprehensions, but using parentheses instead of brackets:

```python
>>> letters = 'abc'
>>> codes = (ord(l) for l in letters)
>>> for code in codes:
...     print(code)
97
98
99
```

Only a generator object rather than a tuple is stored in memory.

## Tuple Unpacking

```python
>>> a, b = b, a  # swapping variables

>>> name, age = ('John', 42)  # unpacking tuple elements
>>> _, age = ('John', 42)  # ignoring values with _

>>> numbers = (16, 3)
>>> quotient, remainder = divmod(*numbers)  # * unpacking
>>> quotient
5
>>> remainder
1
```

Excess items can grabbed using the asterisk notation:

```python
>>> a, b *remainder = range(5)
>>> (a, b, remainder)
(0, 1, [2, 3, 4])

>>> a, b *mid, z = range(5)
>>> (a, b, mid, z)
(0, 1, [2, 3], 4)
```

Nested tuples can be unpacked, too:

```python
>>> rectangles = [
    ('A', (10, 30)),
    ('B', (15, 15)),
    ('C', (20, 40)),
]
>>> for name, (width, height) in rectangles:
...     print(name, width, height)
A 10 30
B 15 15
C 20 40
```

## Sequences

|           | containers                  | flat                                     |
|-----------|-----------------------------|------------------------------------------|
| mutable   | `list`, `collections.deque` | `bytearray`, `memoryview`, `array.array` |
| immutable | `typle`                     | `str`, `bytes`                           |

- containers: heterogenous, hold references
- flat: homogenous, hold values

## Interpreter

`-c cmd`: program passed in a string

    $ python -c 'print("Hello, World!")'
    Hello, World!

`-m mod`: run library module as a script

    $ mkdir -p foo/bar/baz
    $ cat > foo/bar/baz/qux.py
    print('Hello, World!')
    <Ctrl-D>

    $ python -m foo.bar.baz.qux
    Hello, World!

`-i`: inspect interactively after running script

    $ python -i -c 'a = 3 + 2'
    >>> print(a)
    5

`sys.argv[0]` depends on the way the Python interpreter was called:

| Invocation                   | Value of `sys.argv[0]`      |
|------------------------------|-----------------------------|
| `python -m foo.bar.baz.qux`  | full name of located module |
| `python -c 'print("Hello")'` | `-c`                        |

## Interactive Commands

`quit()` terminates both an interactive session and a script:

    $ cat > script.py
    print('foo')
    print('bar')
    quit()
    print('baz')
    <Ctrl-D>

    $ python script.py
    foo
    bar

## Special Comments

Shebang line for executable scripts:

    #!/usr/bin/env python3

Encoding, if _not_ UTF-8 is to be used:

    # -*- coding: cp1252 -*-

## Variadic Functions

Using positional arguments:

```python
def sum(*args):
    result = 0
    for arg in args:
        result += arg
    return result

sum(1, 2, 3) # 6
```

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

## Sequences

|           | containers                  | flat                                     |
|-----------|-----------------------------|------------------------------------------|
| mutable   | `list`, `collections.deque` | `bytearray`, `memoryview`, `array.array` |
| immutable | `typle`                     | `str`, `bytes`                           |

- containers: heterogenous, hold references
- flat: homogenous, hold values

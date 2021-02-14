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
$python -m doctest twice.py
```

## List Comprehensions

nested:

```python
>>> l = [x + y for x in [1,2,3]
               for y in [10,20,30]]
>>> l
[11,21,31,12,22,32,31,32,33]
```

same as:

```python
for x in [1,2,3]:
    for y in [10,20,30]:
        l.append(x+y)
```

## Sequences

|           | containers                  | flat                                     |
| mutable   | `list`, `collections.deque` | `bytearray`, `memoryview`, `array.array` |
| immutable | `typle`                     | `str`, `bytes`                           |

- containers: heterogenous, hold references
- flat: homogenous, hold values

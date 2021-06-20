# Functional Programming in Python

see [Functional Programming in
Python](https://leanpub.com/functionalprogramminginpython) by Martin McBride

## Introduction

Python supports three major programming paradigms:

- Procedural Programming: Code is structured in blocks (functions, loops, if
  statements); simple, but hard to maintain big code bases.
- Object Oriented Programming (OOP): Code is structured in interacting objects;
  this encapsulation makes independent testing easier, the approach scales
  better to larger code bases.
- Functional Programmnig (FP): Functions are used as the main building block;
  a declarative rather than imperative programming style is used.

Those paradigms are usually mixed; however, FP is often neglected.

In FP, functions are _first class objects_: They can be stored in variables,
passed to other functions as parameters, or be returned from functions.

Functions that operate on functions are called _higher order functions_.

A _pure function_ calculates a result without any side effects. Its result only
depends on the input parameters, not on global state. Neither is global state
changed. A pure function called multiple times with the same arguments always
returns the same result.

FP fits well together with immutable objects such as strings and tuples.
Iterators, which do not allow for modification, but for _lazy evaluation_, are
often preferred over lists.

Higher order functions (`filter`, `map`, `apply`) and recursion are preferred
over structural constructs (`if`/`else` branching, loops).

New functions are created dynamically by combining existing functions.

FP has a lot of _advantages_:

- Conciseness: more can be expressed in less lines of code thanks to more
  abstract constructs
- Clarity: the programmer's intention is put across better by using higher-order
  functions like `map` than loop constructs that have to be deciphered line by
  line
- Provability: without side effects, reasoning about programs is easier;
  mathematical correctness proofs become _possible_
- Concurrency: without side effects, functions can be executed independently and
  in parallel and won't cause race conditions

However, this comes with some _disadvantages_:

- Purity is often not possible, because the purpose of many programs is to
  change global state. A line between pure and impure code has to be drawn.
- A lot of learning effort is required to understand functional concepts such as
  lambda expressions, closures, partial functions, currying etc.
- Functional code can be less efficient than structured code due to constructs
  that are less efficient (recursion instead of loops) or more expensive
  (re-building data structures instead of modifying them).

## Functions as Objects

Functions can be stored in variables like, say, a string:

```python
name = 'Dilbert'

employee = name

def say_hi(name):
    return f'Hello, {name}'

greet = say_hi

print(name)
print(employee)
print(say_hi)
print(greet)
```

There are two variables (_aliases_) pointing to the same object in memory:

    Dilbert
    Dilbert
    <function say_hi at 0x7f955db5b040>
    <function say_hi at 0x7f955db5b040>

It's also possible (but hardly advisable) to overwrite a function reference:

```python
def greet(name):
    return f'Hello, {name}'

def say_hi(name):
    return greet(name)

print(say_hi('Dilbert'))

def greet(name):
    return f'Greetings, {name}'

print(say_hi('Wally'))
```

After overwriting the `greet` function, the second implementation is called:

    Hello, Dilbert
    Greetings, Wally

The implementation of `say_hi` function has been modified indirectly, which
could introduce subtle bugs.

Consider the following conversion functions:

```python
def miles_to_kilometers(miles):
    return miles / 1.60934

def usd_to_chf(usd):
    return usd / 0.92

print('500 miles =', miles_to_kilometers(500), 'km')
print('100 usd =', usd_to_chf(100), 'chf')
```

Which perform their conversion independently:

    500 miles = 310.68636832490336 km
    100 usd = 108.69565217391303 chf

However, both functions implement the same conversion mechanism, which can be
generalized:

```python
def convert(f, x):
    return f(x)

print('500 miles =', convert(miles_to_kilometers, 500), 'km')
print('100 usd =', convert(usd_to_chf, 100), 'chf')
```

Both a function and a number are passed to `convert`, which then applies the
function to the number. Any conversion can be made, also between different
types:

```python
def format_currency(x):
    return f'{x:.2f}'

convert(format_currency, 10/3)  # '3.33 chf'
```

The built-in `sorted` function accepts an optional `key` function that allows
for customized sorting:

```python
dilbert = ('Dilbert', 42)
alice = ('Alice', 37)
dogbert = ('Dogbert', 7)
ashok = ('Ashok', 21)

employees = [dilbert, alice, dogbert, ashok]

def get_name(employee):
    return employee[0]

def get_age(employee):
    return employee[1]

by_name = sorted(employees, key=get_name)
by_age = sorted(employees, key=get_age)

print(by_name)
print(by_age)
```

The list of employees is sorted twice: once by name, and once by age:

    [('Alice', 37), ('Ashok', 21), ('Dilbert', 42), ('Dogbert', 7)]
    [('Dogbert', 7), ('Ashok', 21), ('Alice', 37), ('Dilbert', 42)]

The code can be shortened by using unnamed _lambda functions_:

```python
by_name = sorted(employees, key=lambda e: e[0])
by_age = sorted(employees, key=lambda e: e[1])
```

Lambdas consist of a single expression and, thus, should only be used for very
simple computations that can be clearly understood without a function name or
additional comments. Use a regular function if an expression is used more than
once.

Lambdas are function objects that can also be called directly:

```python
>>> (lambda x: x ** 2)(5)
24
```

More practically, they can be returned from functions:

```python
def create_increment_function(step=1):
    return lambda x: x + step

add_one = create_increment_function()
add_two = create_increment_function(step=2)

add_one(5)  # 5
add_two(5)  # 7
```

Operators are not functions, byt can be wrapped in lambda expressions for use
with higher-order functions:

```python
def calculate(op, a, b):
    return op(a, b)

calculate(lambda a, b: a + b, 3, 1)  # 4
calculate(lambda a, b: a * b, 3, 2)  # 6
```

The `operator` module contains pre-defined functions for common operators, so no
lambdas have to be implemented:

```python
import operator

def calculate(op, a, b):
    return op(a, b)

calculate(operator.add, 3, 1)  # 4
calculate(operator.mul, 3, 2)  # 6
```

See the [documentation of the `operator`
module](https://docs.python.org/3/library/operator.html#mapping-operators-to-functions)
for a full list of operators and their function equivalents.

Functions can be _partially applied_, i.e. called with fewer arguments than
expected, which returns a function only expecting the missing arguments:

```python
from functools import partial

def f(a, b, c, x):
    return a * x**2 + b * x + c

f(2, 4, 6, 1)  # x=1: 2x² + 4x + 6 = 12

g = partial(f, 2, 4, 6)
g(1)   # x=1: 2x² + 4x + 6 = 12
g(2)   # x=2: 2x² + 4x + 6 = 22
```

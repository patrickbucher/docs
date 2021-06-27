---
title: Functional Programming in Python
subtitle: Concepts and Examples
author: Patrick Bucher
---

This overview is inspired by [Functional Programming in
Python](https://leanpub.com/functionalprogramminginpython) by Martin McBride.

# Introduction

Python supports three major programming paradigms:

- Procedural Programming: Code is structured in blocks (functions, loops, if
  statements); simple, but hard to maintain big code bases.
- Object Oriented Programming (OOP): Code is structured in interacting objects;
  this encapsulation makes independent testing easier, the approach scales
  better to larger code bases.
- Functional Programmnig (FP): Functions are used as the main building block;
  a declarative rather than imperative programming style is used.

Those paradigms are usually mixed; however, FP is often neglected.

## Functional Concepts

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

## Pros and Cons

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

# Functions as Objects

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

## Sorting

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

## Lambdas

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

Operators are not functions, but can be wrapped in lambda expressions for use
with higher-order functions:

```python
def calculate(op, a, b):
    return op(a, b)

calculate(lambda a, b: a + b, 3, 1)  # 4
calculate(lambda a, b: a * b, 3, 2)  # 6
```

## Operator Functions

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

## Partial Function Application

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

# Mutability

Lists, dictionaries, and sets are _mutable_; numbers, strings, and tuples are
_immutable_. A frozen set is an immutable version of a set. References to any of
those objects are always mutable: by re-assigning a variable, the object pointed
to is _not changed_, but _another object_ is pointed to instead.

Notice that mutability is shallow. A tuple itself cannot be modified, but the
elements of a tuple containing of lists can be modified.

The `sort` method of a list modifies the underlying list, whereas the `sorted`
function returns a sorted copy of the given list.

A list can be copied by passing it to the `list` function:

```python
def tail(l):
    del l[0]
    return l

numbers = [1, 2, 3]
print(tail(numbers))  # [2, 3]
print(numbers)        # [2, 3], too (modified)

numbers = [1, 2, 3]
print(tail(list(numbers)))  # [2, 3]
print(numbers)              # [1, 2, 3], still (unmodified)
```

This, however, is very inefficient. Instead, the `tail` function could work with
slicing to guarantee immutability:

```python
def tail(l):
    return l[1:]

numbers = [1, 2, 3]
print(tail(numbers))  # [2, 3]
print(numbers)        # [1, 2, 3], still (unmodified)
```

Under the hood, slicing is copying, so this solution is not very efficient, too.

Modifications that affect every single item of a list can be expressed using
_list comprehensions_:

```python
numbers = [1, 2, 3]
twice = [x * 2 for x in numbers]
print(twice)  # [2, 4, 6]
```

# Recursion

Functions that call themselves are a common technique in functional programming.
A problem is thereby reduced to its base case, which is defined statically. In
the general case, a problem is simplified towards the base case:

```python
def factorial(n):
    if n == 0:
        return 1
    elif n > 0:
        return n * factorial(n - 1)

print(factorial(2))  # 2
print(factorial(3))  # 6
print(factorial(4))  # 24
```

The bigger the argument `n` is chosen, the more functions are running at the
same time:

    factorial(6)
    6 * factorial(5)
    6 * 5 * factorial(4)
    6 * 5 * 4 * factorial(3)
    6 * 5 * 4 * 3 * factorial(2)
    6 * 5 * 4 * 3 * 2 * factorial(1)
    6 * 5 * 4 * 3 * 2 * 1 factorial(0)
    6 * 5 * 4 * 3 * 2 * 1 * 1
    6 * 5 * 4 * 3 * 2 * 1
    6 * 5 * 4 * 3 * 2
    6 * 5 * 4 * 6
    6 * 5 * 24
    6 * 120
    720

This doesn't scale well. An alternative approach to recursive functions are
tail-recursive functions, which carry intermediate results as an extra
accumulator parameter (`acc`):

```python
def factorial(n, acc=1):
    if n == 0:
        return acc
    elif n > 0:
        return factorial(n-1, n * acc)
```

## (No) Tail Call Optimization

Some compilers are able to optimize tail-recursive functions by re-using stack
frames for multiple function calls. Unfortunately, Python doesn't support this
optimization, so other solutions needs to be considered, such as loops.

Recursion becomes even more inefficient as multiple additional functions are
called in each step, as a recursive implementation of a function to compute the
Fibonacci numbers requires:

```python
def fib(n):
    print(f'fib({n})')
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fib(n-2) + fib(n-1)
```

The `print` call makes the amount of (redundant) functions being called
apparent:

    >>> fib(6)
    fib(6)
    fib(4)
    fib(2)
    fib(0)
    fib(1)
    fib(3)
    fib(1)
    fib(2)
    fib(0)
    fib(1)
    fib(5)
    fib(3)
    fib(1)
    fib(2)
    fib(0)
    fib(1)
    fib(4)
    fib(2)
    fib(0)
    fib(1)
    fib(3)
    fib(1)
    fib(2)
    fib(0)
    fib(1)
    8

The `fib` function is called with the argument `1` alone eight times. The
inefficiency becomes even more striking when using a bigger `n` and counting the
function calls (`fibonacci.py`):

```python
calls = 0

def fib(n):
    global calls
    calls += 1
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fib(n-2) + fib(n-1)

print(f'fib(35)={fib(35)} after {calls} calls')
```

Almost 30 million function calls in a bit less than five seconds are required to
compute the 35th Fibonacci number:

```bash
$ time python3 fibonacci.py
fib(35)=9227465 after 29860703 calls

real    0m4.948s
user    0m4.946s
sys     0m0.000s
```

## Memoization

When many intermediate results are computed multiple times, re-using those
results helps saving function calls. For this purpose, the function arguments
are (keys) are put together with the results (values) into a dictionary. This
technique is called _memoization_:

```python
calls = 0
cache = {}

def fib(n):
    global calls
    calls += 1
    if n in cache:
        return  cache[n]
    else:
        if n == 0:
            result = 0
        elif n == 1:
            result = 1
        else:
            result = fib(n-2) + fib(n-1)
        cache[n] = result
        return result

print(f'fib(35)={fib(35)} after {calls} calls')
```

Which reduces function calls by a factor of more than 4*10⁵, and runtime by a
factor of roughly 167 (memoization comes with a slight overhead).

```bash
fib(35)=9227465 after 69 calls

real    0m0.030s
user    0m0.030s
sys     0m0.000s
```

Memoization is a _cross cutting concern_ that has little to do with the function
itself. Python's `functools` has a decorator `lru_cache` (least recently used
cache) which provides memoization out-of-the-box:

```python
from functools import lru_cache

calls = 0

@lru_cache
def fib(n):
    global calls
    calls += 1
    if n == 0:
        result = 0
    elif n == 1:
        result = 1
    else:
        result = fib(n-2) + fib(n-1)
    return result

print(f'fib(35)={fib(35)} after {calls} calls')
```

Even less functions are invoked, because the caching mechanism is around the
function:

```bash
fib(35)=9227465 after 36 calls

real    0m0.029s
user    0m0.025s
sys     0m0.004s
```

## Flattening Lists

Lists in Python can be nested:

```python
[1, [2, [3, 4, [5, 6], 7], 8], 9]
```

Such a list contains numbers and lists, which again contain numbers and lists,
and so on. It is often useful to _flatten_ such a list:

```python
[1, 2, 3, 4, 5, 6, 7, 8, 9]
```

For this purpose, a recursive implementation processes the nested list one by
one. The first element (`head`) of the remaining list is considered in each
function call, and the remaining elements (`tail`) are delegated to another
recursive call. Then, the solution is combined:

```python
def flatten(x):
    if not isinstance(x, list):
        # x is a number: first base case
        return [x]
    if x == []:
        # x is an empty list: second base case
        return x
    else:
        # x is a non-empty list: general case
        return flatten(x[0]) + flatten(x[1:])
```

Memoization won't help here, because `x` is different for every function call. A
more feasible approach would be to fall back to loops:

```python
def flatten(x):
    if not isinstance(x, list):
        # x is a number: first base case
        return [x]
    if x == []:
        # x is an empty list: second base case
        return x
    else:
        # x is a non-empty list: general case
        r = []
        for e in x:
            if isinstance(e, list):
                r += flatten(e)
            else:
                r.append(e)
        return r
```

A recursive function call here only takes place for each additional depth level,
not for every additional element.

# Closures

Functions can contain other functions. The inner function cannnot be seen from
the outside of the outer function, unless the outer function returns the inner
function. In this example, an inner function `grade` is used from the outer
function `grade_exams`.

```python
def grade_exams(candidate_scores, max_score):

    def grade(score):
        # Swiss grades: 1..6
        return score / max_score * 5 + 1
    
    candidate_grades = {}
    for candidate, score in candidate_scores.items():
        candidate_grades[candidate] = grade(score)

    return candidate_grades

exam_max_score = 50
exam_scores = {
    'Alice': 42,
    'Bob': 35,
    'Mallory': 49,
}
exam_grades = grade_exams(exam_scores, exam_max_score)
print(exam_grades) # {'Alice': 5.2, 'Bob': 4.5, 'Mallory': 5.9}
```

## Returning Inner Functions

Notice how each `score` is passed to `grade`, but `max_score` is taken from the
outer scope. The inner function even has access to the outer function's scope if
it is returned from the outer function and used elsewhere. The outer function
_encloses_ the inner function; this construct therefore is called a _closure_:

```python
def get_compute_salary_func(year):

    bonus_rates = {
        2018: 0.05,
        2019: 0.10,
        2020: 0.07,
    }
    bonus_rate = bonus_rates.get(year, 0.0)

    def compute_yearly_salary(monthly):
        base_salary = monthly * 12
        bonus = base_salary * bonus_rate
        return base_salary + bonus

    return compute_yearly_salary

compute_2016_salaries = get_compute_salary_func(2016)
compute_2018_salaries = get_compute_salary_func(2018)
compute_2020_salaries = get_compute_salary_func(2020)

print(compute_2016_salaries(80000))  #  960000.0
print(compute_2018_salaries(80000))  # 1008000.0
print(compute_2020_salaries(80000))  # 1027200.0
```

In the example above, the outer function `get_compute_salary_func` encloses the
inner function `compute_yearly_salary`; the latter using the variable
`bonus_rate` established in the former's scope. Even though the same function is
used multiple times, it computes different results, because the enclosing scope
is different.

## Map

A dictionary is a Python data structure that describes the relationship between
a key and a value in a static way. The `map` function can be seen as the dynamic
counterpart of a `dict`. It is a higher-order function that processes a
collection of items using a given function, and returns a collection consisting
of the function's return value for each item:

```python
max_score = 50
exam_scores = [42, 35, 49]

def grade(score):
    # Swiss grades: 1..6
    return score / max_score * 5 + 1

exam_grades = map(grade, exam_scores)
print(list(exam_grades))  # [5.2, 4.5, 5.9]
```

No explicit looping over the individual scores is needed, the `map` function
handles those details. The code can be further simplified by using a lambda
instead of a named function:

```python
max_score = 50
exam_scores = [42, 35, 49]
exam_grades = map(lambda score: score / max_score * 5 + 1, exam_scores)
print(list(exam_grades))
```

This works with any kind of functions, i.e. also with a closure _primed_ with
a value, like in the salary example from before:

```python
def get_compute_salary_func(year):

    bonus_rates = {
        2018: 0.05,
        2019: 0.10,
        2020: 0.07,
    }
    bonus_rate = bonus_rates.get(year, 0.0)

    def compute_yearly_salary(monthly):
        base_salary = monthly * 12
        bonus = base_salary * bonus_rate
        return base_salary + bonus

    return compute_yearly_salary

compute_2020_salaries = get_compute_salary_func(2020)
base_salaries = [80000, 90000, 100000]
total_salaries = map(compute_2020_salaries, base_salaries)
print(list(total_salaries))
```

## Composing Functions

Consider the value `x` that has to be processed by two functions `f` and `g`:

1. `y` is computed as `y=g(x)` (intermediate result)
2. `z` is computed as `z=f(y)` (final result)

This, of course, can be simplified by _composing_ the two functions `f` and `g`
as `f(g(x))`.

Consider this example, where exam scores are first mapped to exam grades, which
then are rounded in a second step:

```python
def get_grade_for_func(max_score):

    def grade(score):
        return score / max_score * 5 + 1

    return grade

def get_round_to_func(granularity):

    def round_to(value):
        scaled_up = value * (1 / granularity)
        rounded = round(scaled_up)
        scaled_down = rounded * granularity
        return scaled_down
    
    return round_to

max_score = 72
scores = [46, 70, 53, 38, 67]

grade_for = get_grade_for_func(max_score)
round_to = get_round_to_func(0.1)

exact_grades = map(grade_for, scores)
rounded_grades = map(round_to, exact_grades)

print(list(rounded_grades))  # [4.2, 5.9, 4.7, 3.6, 5.7]
```

This approach requires two calls to `map`, with each call iterating over all the
elements. If the grader and rounding function are composed to a single function,
the list only needs to be processed once:

```python
def get_grade_for_func(max_score):

    def grade(score):
        return score / max_score * 5 + 1

    return grade

def get_round_to_func(granularity):

    def round_to(value):
        scaled_up = value * (1 / granularity)
        rounded = round(scaled_up)
        scaled_down = rounded * granularity
        return scaled_down
    
    return round_to

max_score = 72
scores = [46, 70, 53, 38, 67]

grade_for = get_grade_for_func(max_score)
round_to = get_round_to_func(0.1)

def compose(f, g):
    def func(x):
        return f(g(x))
    return func

score_to_rounded_grade = compose(round_to, grade_for)

rounded_grades = map(score_to_rounded_grade, scores)

print(list(rounded_grades))  # [4.2, 5.9, 4.7, 3.6, 5.7]
```

This approach scales much better: Not only in terms of runtime efficiency, which
becomes noticable as the number of elements grows, but only if additional
computations need to be done for every item.

In this example, an additional point bonus is added to each score, so that the
maximum grade can be reached without a perfect score:

```python
def get_bonus_of_func(bonus):

    def add(score):
        return score + bonus

    return add

def get_grade_for_func(max_score):

    def grade(score):
        return score / max_score * 5 + 1

    return grade

def get_round_to_func(granularity):

    def round_to(value):
        scaled_up = value * (1 / granularity)
        rounded = round(scaled_up)
        scaled_down = rounded * granularity
        return scaled_down
    
    return round_to

max_score = 100
scores = [70, 80, 90, 40, 100]

bonus_of = get_bonus_of_func(max_score / 10)
grade_for = get_grade_for_func(max_score)
round_to = get_round_to_func(0.1)

def compose(f, g):

    def func(x):
        return f(g(x))

    return func

score_to_exact_grade = compose(grade_for, bonus_of)
score_to_rounded_grade = compose(round_to, score_to_exact_grade)

rounded_grades = map(score_to_rounded_grade, scores)

print(list(rounded_grades))  # [5.0, 5.5, 6.0, 3.5, 6.5]
```

Unfortunately, this brings up another issues: Grades higher than the maximum
grade of 6.0 are computed. However, this issues can be solved by composing even
further:

```python
def get_bonus_of_func(bonus):

    def add(score):
        return score + bonus

    return add

def get_grade_for_func(max_score):

    def grade(score):
        return score / max_score * 5 + 1

    return grade

def get_limit_of_func(max_grade):

    def limit(grade):
        return min(grade, max_grade)

    return limit


def get_round_to_func(granularity):

    def round_to(value):
        scaled_up = value * (1 / granularity)
        rounded = round(scaled_up)
        scaled_down = rounded * granularity
        return scaled_down
    
    return round_to

max_score = 100
scores = [70, 80, 90, 40, 100]

bonus_of = get_bonus_of_func(max_score / 10)
grade_for = get_grade_for_func(max_score)
limit_of = get_limit_of_func(6.0)
round_to = get_round_to_func(0.1)

def compose(f, g):

    def func(x):
        return f(g(x))

    return func

score_to_exact_grade = compose(grade_for, bonus_of)
score_to_bounded_grade = compose(limit_of, score_to_exact_grade)
score_to_rounded_grade = compose(round_to, score_to_bounded_grade)

rounded_grades = map(score_to_rounded_grade, scores)

print(list(rounded_grades))  # [5.0, 5.5, 6.0, 3.5, 6.0]
```

Compare this to a procedural approach, which is much shorter in terms of lines:

```python
max_score = 100
scores = [70, 80, 90, 40, 100]
bonus = max_score / 10
max_grade = 6.0
granularity = 0.1

grades = []
for score in scores:
    score = score + bonus
    grade = score / max_score * 5 + 1
    if grade > max_grade:
        grade = max_grade
    grade = round(grade * 1 / granularity) * granularity
    grades.append(grade)

print(grades)  # [5.0, 5.5, 6.0, 3.5, 6.0]
```

However, this code is harder to reason about ("Where did the error happen?"),
especially if the computations are getting more involved. The functional
approach allows you to reason about and write tests for each function in
isolation. If the functions work correctly, are composed in the right way and
used with well-tested higher-order functions like `map` , the result will be
correct, too.

## Closures vs. Classes

Like objects, closures can hold state. In OOP, the state can be initialized
using a constructor. A method of the same class then can perform computations
based on both internal state and parameters:

```python
class Rounder:

    def __init__(self, granularity):
        self._granularity = granularity

    def round(self, value):
        scaled_up = value * (1 / self._granularity)
        rounded = round(scaled_up)
        scaled_down = rounded * self._granularity
        return scaled_down

grades = [5.234, 4.738, 3.269]
rounder = Rounder(0.05)
rounded = map(rounder.round, grades)
print(list(rounded))  # [5.25, 4.75, 3.25]
```

Python has a special method `__call__`, which allows objects to be used like
functions. The above implementation can be turned more pythonesque by, first,
renaming `round` to `__call__`, and, second, by using `rounder` as a function
(instead of its method `rounder.round`). Calls to `rounder()` will be delegated
to the `__call__` method:

```python
class Rounder:

    def __init__(self, granularity):
        self._granularity = granularity

    def __call__(self, value):
        scaled_up = value * (1 / self._granularity)
        rounded = round(scaled_up)
        scaled_down = rounded * self._granularity
        return scaled_down

grades = [5.234, 4.738, 3.269]
rounder = Rounder(0.05)
rounded = map(rounder, grades)
print(list(rounded))  # [5.25, 4.75, 3.25]
```

This approach is useful when objects first need to be configured in a
complicated but inconsistent manner. Think of the Builder pattern, that allows
to initialize objects only using a subset of available parameters:

```python
class Salary:

    _bonus = 0
    _taxes = 0
    _penalty = 0

    def __init__(self, amount):
        self._salary = amount

    def with_bonus(self, rate):
        self._bonus = rate
        return self

    def with_taxes(self, rate):
        self._taxes = rate
        return self

    def with_penalty(self, penalty):
        self._penalty = penalty
        return self

    def __call__(self):
        pre_bonus = (self._salary - self._penalty)
        pre_taxes = pre_bonus + pre_bonus * self._bonus
        return pre_taxes - pre_taxes * self._taxes

salary_1 = Salary(100000).with_bonus(0.1).with_penalty(5000)
salary_2 = Salary(100000).with_bonus(0.1).with_taxes(0.2)
print(salary_1())  # 104500.0
print(salary_2())  #  88000.0
```

A function returning a closure requires optional parameters for the same
purpose:

```python
def get_salary_func(bonus=0, taxes=0, penalty=0):

    def compute(salary):
        pre_bonus = (salary - penalty)
        pre_taxes = pre_bonus + pre_bonus * bonus
        return pre_taxes - pre_taxes * taxes

    return compute

salary_1 = get_salary_func(bonus=0.1, penalty=5000)
salary_2 = get_salary_func(bonus=0.1, taxes=0.2)
print(salary_1(100000))  # 104500.0
print(salary_2(100000))  #  88000.0
```

## Inspecting Closures

Python provides the special attributes `__closure__` and `__code__` to inspect
closures (see the [Data
Model](https://docs.python.org/3/reference/datamodel.html) for details).

The variables a function has access to by enclosing an outer scope—so-called
_free variables_—can be retrieved as a tuple using the `co_freewars` attribute
of the `__code__` attribute. To get the values of those free variables, inspect
the `cell_contents` attribute of each element of the `__closure__` attribute:

```python
def get_salary_func(bonus=0, taxes=0, penalty=0):

    def compute(salary):
        pre_bonus = (salary - penalty)
        pre_taxes = pre_bonus + pre_bonus * bonus
        return pre_taxes - pre_taxes * taxes

    return compute

salary = get_salary_func(bonus=0.1, penalty=5000)
print(salary.__code__.co_freevars)  # ('bonus', 'penalty', 'taxes')
print(salary.__closure__[0].cell_contents)  # 0.1
print(salary.__closure__[1].cell_contents)  # 5000
print(salary.__closure__[2].cell_contents)  # 0
```

This process can be simplified using an utility function:

```python
def get_salary_func(bonus=0, taxes=0, penalty=0):

    def compute(salary):
        pre_bonus = (salary - penalty)
        pre_taxes = pre_bonus + pre_bonus * bonus
        return pre_taxes - pre_taxes * taxes

    return compute

salary = get_salary_func(bonus=0.1, penalty=5000)

def inspect_closure(func):
    for i, name in enumerate(func.__code__.co_freevars):
        print(f'{name} = {func.__closure__[i].cell_contents}')

inspect_closure(salary)
```

Which outputs all the free variables of a closure:

    bonus = 0.1
    penalty = 5000
    taxes = 0

Notice that those are read-only values, don't attempt to manipulate those
closures: better create a new one.

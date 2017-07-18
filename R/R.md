# R

## Environment

Set a custom prompt (`R> `):

    options(prompt = "R> ")

List variables, objects and user-defined functions of the current session:

    ls()

Leave R:

    q()

### Sessions

Find out and set the current working directory:

    getwd()
    setwd("~/my-workspace")

Save the current session:

    save.image("my-session.RData")

Load a stored session:

    load("my-session.RData")

### Packages

Install a new package (`MASS`, for example):

    library("MASS")

Update installed packages:

    update.packages()

### Help

Get help for a specific keyword (the `mean` function, for example):

    help("mean")
    ?mean # shortcut

Search for a help topic (`random`, for example):

    help.search("random")
    ??"random" # shortcut

## Language Basics

Comments, starting with `#` to the end of the line:

    1 + 1 # calculates one plus one, which is two

Exponential notation:

    1e3 # 1 * 10^3 = 1000
    1e-3 # 1 * 10^(-3) = 0.001

Assignments:

    a <- 17
    b = 42

## Calculations

Basic arithmetic:

    3 + 5 # 8
    5 - 2 # 3
    2 * 3 # 6
    9 / 3 # 3
    2 ^ 3 # 8 (2 to the power of 3)
    sqrt(16) # 4

Logarithms:

    log(x = 8, base = 2) # 3, because 2^3 = 8
    log(8, 2) # same but shorter

Euler's number as an exponantial function:

    exp(1) # 2.718282

The `log()` function uses Euler's number as the default base (natural logarithm):

    log(100) # 4.60517
    log(x = 100, base = exp(1)) # same with an explicit base

The `exp()` function is the reverse function of `log()`:

    log(exp(23)) # 23

## Vectors

Make a vector from individual elements:

    c(1, 2, 3) # 1 2 3

### Sequences

Make a sequence from one to ten:

    seq(from = 1, to = 10, by = 1)
    1:10 # same but shorter (default step = 1)

Make a sequence with a specific length instead of step size, which will be
calculated automatically:

    seq(from = 1, to = 10, length.out = 4) # 1 4 7 10

Make a sequence with a specific length and step size, but ommit the upper
boundry:

    seq(from = 1, by = 2, length.out = 5) # 1 3 5 7 9

### Repetitions

Repeat a number:

    rep(x = 1, times = 3) # 1 1 1
    rep(1, 3) # same but shorter

Repeat a sequence:

    rep(c(1, 2, 3), 2) # 1 2 3 1 2 3
    rep(1:3, 2), # same but shorter

Repeat items instead of the whole sequence:

    rep(1:3, each = 2) # 1 1 2 2 3 3

Repeat using `eech` and `times` combined:

    rep(1:2, each = 2, times = 2) # 1 1 2 2 1 1 2 2

### Sorting

Sort (in ascending order):

    sort(3:-3) # -3 -2 -1 0 1 2 3

Sort (in descending order):

    sort(1:5, decreasing = TRUE) # 5 4 3 2 1

Reverse the order of a vector's elements:

    rev(1:5) # 5 4 3 2 1

### Accessing Elements

For the following examples, the vector `v` is used:

    v <- seq(from = 10, to = 50, by = 10) # 10 20 30 40 50 

Access the first element (the first index is 1):

    v[1] # 10

Access the last element (the last index is the vector's length):

    v[length(v)] # 50

Access multiple elements:

    v[c(1, 3, 5)] # 10 30 50
    v[1:3] # 10 20 30

Ommit the element at a certain index:

    v[-1] # 20 30 40 50
    v[-length(v)] # 10 20 30 40

Ommit multiple elements:

    v[-c(1, 2, 3)] # 40 50

Overwrite vector elements:

    v[1] = 11 # v = 11 20 30 40 50
    v[c(2, 3)] = c(22, 33) # v = 11 22 33 40 50
    v[c(4, 5)] = 44 # v = 11 22 33 44 44, 44 was used twice!
    v[1:4] = c(1, 2) # v = 1 2 1 2 44

The vector on the left hand side must either have:

- the same size as the vector on the right hand side, or
- a size multiple times as big as the vector on the right hand side.

### Arithmetic on Vectors

Multiply every item of the vector by 2:

    1:6 * 2 # 2 4 6 8 10 12

Multiply the items of the vector by 1 and -1, respectively:

    1:6 * c(1,-1) # 1 -2 3 -4 5 -6

For the vector's sizes, the same rule applies as stated above.

Calculate the sum of a vector:

    sum(1, 2, 3, 4) # 1+2+3+4=10
    sum(1:100) # 5050

Calculate the product of a vector:

    prod(1, 2, 3, 4) # 1*2*3*4=4!=24
    prod(1:4) # same but shorter

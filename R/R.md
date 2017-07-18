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

    seq(from = 1, to = 20, length.out = 4)

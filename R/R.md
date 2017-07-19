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

Make a sequence with a specific length and step size, but omit the upper
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

Omit the element at a certain index:

    v[-1] # 20 30 40 50
    v[-length(v)] # 10 20 30 40

Omit multiple elements:

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

## Matrices

Create a 2x2 matrix:

    matrix(data = c(1, 2, 3, 4), nrow = 2, ncol = 2)

Either `nrow` or `ncol` can be omitted:

    matrix(1:16, nrow = 4) # 4x4 matrix (16 items)
    matrix(1:25, ncol = 5) # 5x5 matrix (25 items)

If both `nrow` and `ncol` are omitted, a one-row matrix will be created:

    matrix(1:10) # 1x10 matrix (10 items)

By default, the  matrix is filled up by column:

    matrix(1:6, ncol = 2)

    1   4
    2   5
    3   6

This behaviour can be changed using the `byrow` parameter:

    matrix(1:6, ncol = 2, byrow = TRUE)

    1   2
    3   4
    5   6

Matrices can be built up from vectors of same lengths:

    rbind(1:3, 4:6) # by row

    1   2   3
    4   5   6

    cbind(1:3, 4:6) # by column

    1   4
    2   4
    3   6

Find out the dimensions of a matrix:

    m <- matrix(1:12, nrow = 3, ncol = 4)

    1   4   7   10
    2   5   8   11
    3   6   9   12

    dim(m) # 3 4 (a vector)
    dim(m)[1] # 3, number of rows
    nrow(m) # same but shorter
    dim(m)[2] # 4, number of cols
    ncol(m) # same but shorter

Access a matrix element:

    m <- matrix(1:6, ncol = 3)

    1   3   5
    2   4   6

    m[1,2] # 3 [row, col]

Access a whole row or column (returns a vector):

    m[1,] # 1 3 5, first row
    m[,2] # 3 4, second column

Rows and columns can be accessed using vectors:

    m[1:2,] # rows 1 and 2
    m[,c(1,3)] # cols 1 and 3

This makes it possible to select parts of a matrix:

    m <- matrix(1:9, ncol = 3)

    1   4   7
    2   5   8
    3   6   9

    m[1:2, c(1,3)] # rows 1 and 2, cols 1 and 3

    1   7
    2   8

Access the diagonal values as a vector:

    diag(m) # 1 5 9

Omit parts of a matrix:

    m[-1,] # omit the first row
    m[,-2] # omit the second column
    m[-(2:3), -c(1,4)] # omit rows 2 to 3, columns 1 and 4

Matrix rows and columns can be overwritten like any vector (the same length
rules apply):

    m[1,] = 6 # set every value in the first row to 6
    m[1:2, 2:3 = 7] # the values in the sub-matrix [1,2] to [2,3] are set to 7
    m[,2] = c(1,2) # the values in the second column are set to 1, 2, 1, 2 etc.
    m[1,] = m[2,] # overwrite the first row using the values of the second row
    m[c(1, nrow(m)), c(1, ncol(m))] = -1 # set the values in the "corners" to -1

### Operations and Algebra

Transpose a matrix ($$ A^T $$ is the transposed matrix of $$ A $$):

    A <- matrix(1:9, ncol = 3)

    1   4   7
    2   5   8
    3   6   9

    t(A)

    1   2   3
    4   5   6
    7   8   9

Create an identity matrix of size $$ n $$ ($$ I_n $$):

    I <- diag(x = 3)

    1   0   0
    0   1   0
    0   0   1

Scalar multiplication of a matrix:

    A <- rbind(1:3, 4:6)

    1   2   3
    4   5   6

    A * 2

    2   4   6
    8  10  12

Addition and substraction of matrices:

    A <- matrix(1:4, ncol = 2)
    B <- matrix(5:8, ncol = 2)

    A + B

    1   3       5   7       6  10
            +           =   
    2   4       6   8       8  12

    B - A

    5   7       1   3       4   4
            +           =
    6   8       2   4       4   4

Two matrices, $$ A(m,n) $$ and $$ B(p,q) $$ can be multiplied if $$ n = p $$
holds true (first matrix' cols = second matrix' rows), resulting in a matrix
with $$ m $$ rows and $$ q $$ cols:

    A <- matrix(c(2,6,5,1,2,4), ncol = 3) # n = 3
    B <- matrix(c(3,-1,1,-3,1,5), nrow = 3) # p = 3

    A %*% B

    x        B = 3  -3
                -1   1
                 1   5
    A = 
    2   5   2  | 3   9| = AxB
    6   1   4  |21   3|

$$ A^{-1} $$ is the inverse of a matrix $$ A $$. $$ A $$ multiplied by $$ A^{-1}
$$ results in the identity matrix:

    A <- matrix(3,4,1,2), ncol = 2)

    3   1
    4   2

    solve(A)

     1  -0.5
    -2   1.5

    A %*% solve(A) # check the result: is it the identity matrix?

    1   0
    0   1

Summary:

- inverse matrix: $$ A^{-1} $$, `solve(A)`
- transposed matrix: $$ A^T $$, `t(A)`
- identity matrix: $$ I_n $$, `diag(x = n)`

## Multidimensional Arrays

Define arrays of different dimension:

    array(data = 1:24) # vector 1 2 3 ... 24, 1 dimension
    array(data = 1:24, dim = c(24)) # same with explicit dimension
    array(data = 1:24, dim = c(4, 6)) # a 4x6 matrix, 2 dimensions
    array(data = 1:24, dim = c(2, 3, 4)) # a 2x3x4 "cube", 3 dimensions

The dimension `(2, 3, 4)` stands for 2 rows, 3 cols and 4 layers. The product of
the elements in the dimension vector must be equal to the length of the data
vector.

Accessing parts of a multidimensional array:

    AR <- array(1:24, c(2, 3, 4))
    AR[1,,] # access the first row
    AR[,2,] # access the second column
    AR[,,3] # access the third layer

    AR[1,,c(1, 2)] # first row of first and second layer

For arrays, the same assignment rules of vectors and matrices also apply.

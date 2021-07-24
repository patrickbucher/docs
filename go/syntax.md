# Syntax

## `for` Loop

The C-style `for` loop without parentheses:

    for initialization; condition; post {
        // zero or more statements
    }

- initialization: simple statement (variable declaration, function call)
- condition: expression returning a boolean value
- post: statement to be executed after every iteration

If initialization and post statement are omitted, it resembles a traditional
`while` loop:

    for condition {
        // zero or more statements
    }

The condition can be left away to create an infinite loop:

    for {
        // zero or more statements
        // break or return to end the loop
    }

### `for`/`range` loop

Looping over a slice, the `range` keyword produces a pair of variables, index
and value:

    for i, v := range s {
        // s[i] == v
    }

Looping over a map, `range` returns a key-value pair:

   for k, v := range m {
        // m[k] == v
   }

The values returned by `range` can also be omitted, looping len(s) times
without caring about the individual values of the slice:

    for range s {
        // do something
    }

## Increment/Decrement

The increment and decrement operators are short forms of adding/subtracting
one:

    a := 0

    a += 1 # 1
    a++ # 2

    a -= 1 # 1
    a-- # 0

The increment and decrement operators are statements, not expressions:

    i := 1
    j := 2
    i = j++ # illegal!

There is only a suffix but no prefix form:

    i := 0
    i++
    i--
    ++i # illegal!
    --i # illegal!

## `len` Function

Return the length of a slice or map:

    s := []string{"foo", "bar", "baz"}
    len(s) // 3

    m := map[string]int{"a": 1, "b", 2, "c", 3}
    len(m) // 3

## Arrays

Arrays can be initialized with an array literal, defining its length:

    a := [3]int{1, 2, 3}

The length can be omitted, leaving its determination up to the compiler:

    b := [...]int{1, 2, 3}

Specific items can be initialized by providing their indices:

    fib := [...]int{0: 1, 1: 1, 2: 2, 3: 3, 4: 5}

Not all indices have to be set upon initialization, making use of the automatic
zero initialization:

    c := [...]int{99: 10} // all entries are zero, except the last at index 99
    len(c) // 100 

Arrays of equal length can be compared:

    a := [...]int{1, 2, 3}
    b := [...]int{1, 2, 3}
    c := [...]int{2, 1, 3}

    a == b // true
    a == c // false, same elements but different order

The length of an array belongs to its type definition! A function requiring a
`[16]byte` array won't accept a `[32]byte` array.

    a := [...]int{1, 2, 3}
    d := [...]int{2, 1, 3, 4}
    a == d // compile error (mismatched types [3]int and [4]int)

## Slicing

Access an individual item `i` in a slice `s`:

    s[i]

Access a subsequence from `m` (inclusive) to `n` (exclusive) in a slice `s`:

    s[m:n] # elements m to n-1

The size of the resulting slice is `n-m`.

Get the length of the slice `s`:

    len(s)

Lower boundaries default to zero if missing:

    s[:n] # elements 0 to n-1

Upper boundaries default to `len(s)` if missing:

    s[m:] # elements m to len(s)-1

If both boundaries are omitted, the colon can be omitted, too:

    s[:] # elements 0 to len(s)-1
    s # same as above

Slices cannot be compared to each other for equalty using the `==` operator.
The only legal comparison is against `nil`:

    a := []int{1, 2, 3}
    b := []int{9, 8, 7}

    a == b // illegal
    a != b // illegal

    a != nil // legal
    b == nil // legal

## Blank Identifier `_`

If a returned variable is not of interest, and since unused variables cause a
compilation error, it can be discarded using the blank identifier `_`:

    err, val := foo.Bar()
    _, val := foo.Bar()
    err, _ := foo.Bar()

## String Concatenation

The `+` operator concatenates two strings:

    a := "foo"
    b := "bar"
    c := a + b // "foobar"

String concatenation can be combined with an assignment operator:

    a := "foo"
    a += "bar" # "foobar"

## Variable Declaration

There are four ways of declaring a variable:

1. `s := ""`
    - shortest and most used form
    - only within functions
    - to be used when the initial value is important
2. `var s string`
    - commonly used
    - relies on default initialization
    - also allowed outside of functions
    - to be used when the initial value is _not_ important
3. var s = ""
    - used for declaration of multiple variables
4. var s string = ""
    - redundant type/value declaration
    - useful if default value of a type an initialization value differ

Option 1 and 2 are generally prefered.

### Initialization

Variables default to a zero value, defined by its type:

    var i int       // 0
    var f float32   // 0.0
    var s string    // ""

The elements of compund types also default to zero:

    zeroes := make([]int, 3)
    fmt.Println(zeroes[0], zeroes[1], zeroes[2]) // 0 0 0

### Multiple Declarations

Multiple variables can be declared with one `var` statement:

    var a, b, c int

### Tuple Assignment

Multiple variables can be declared and assigned a value:

    a, b, c := 1, 2, 3

### The `new` Function

Variables of any type can be declared using the `new` function:

    i := new(int)
    f := new(float32)
    s := new(string)

The `new` function returns a pointer:

    fmt.Println(i, f, s) // prints addresses
    fmt.Println(*i, *f, *s) // prints values

## Package Declaration

Declare the package name on the top of a file:

    package main

## Package Imports

Import a single package:

    import "fmt"

Import multiple packages:

    import (
        "fmt"
        "os"
        "strings"
    )

## Functions

A function can have a parameter list and a result list of 0..n elements:

    func name(parameter-list) (result-list) {
        body
    }

If multiple consecutive parameters and results share the same type, it can be
"factored" out:

    func name(a int, b int, c int) (x int, y int, z int) {
    }

Thus can be written shorter as:

    func name(a, b, c int) (x, y, z int) {
    }

### Multiple Return Values

A function can return multiple values:

    func integerDivision(a, b int) (int, int) {
        return a / b, a % b
    }

The return values can also be named for better understanding:

    func integerDivison(a, b int) (quotient, remainder int) {
        // ...
    }

The named return values behave like variable declarations (with zero-value
initialization), and thus can be assigned a value:

    func integerDivison(a, b int) (quotient, remainder int) {
        quotient = a / b
        remainder = a % b
        return quotient, remainder
    }

If the named return values should be returned and have a value assigned, a
_bare return_ statement can be used:

    func integerDivison(a, b int) (quotient, remainder int) {
        quotient = a / b
        remainder = a % b
        return 
    }

### Function Literal

A function literal can stand wherever a function reference can. Thus this code:

    func handler(w http.ResponseWriter, r *http.Request) {
        // ...
    }
    http.HandleFunc("/", handler)

Can be rewritten as:

    http.HandleFunc("/", func (w http.ResponseWriter, r *http.Request) {
        // ... 
    })

Such a function is called -- for its lack of a name -- a anonymous function.

## `make`

The `make` builtin function is used to build data structures, such as a `map`.

### Function Values

A function can be assigned to a variable and called using that variable:

    f := math.Pow
    z := f(2, 4) // math.Pow(2, 4) = 16

The function's type is defined by its argument and result list:

    f := math.Pow
    fmt.Printf("%T") // func(float64, float64) float64

A function variable can only be re-assigned to a matching type:

    func add(a, b int) int {
        return a + b
    }

    func div(a, b int) float64 {
        return float64(a) / float64(b)
    }

    op := add // func(int, int) int
    op = div // illegal: func(int, int) float64 is a different type!

A functions zero value is nil:

    var g func(int, int) int
    fmt.Println(g) // <nil>

Function values are not comparable, but can be testet for nil:

    if g == nil {
        // ok
    } else if g == f {
        // illegal
    }

### Closures

A function with an enclosing scope is called a closure:

    func fibonacci() func() int {
        i, j := 0, 1
        return func() int {
            j, j = j, j+i
            return i
        }
    }

On every subsequent call of f(), the next Fibonacci number is calculated:

    f := fibonacci()
    f() // 1
    f() // 1
    f() // 2
    f() // 3
    f() // 5
    f() // 8

The function fibonacci() _closes over_ the anonymous function that calculates
and returns the result.

#### Pitfall: Iteration Variables

These items should be iterated over and be printed out _after_ the iteration:

	items := []string{"foo", "bar", "qux"}

For every item, a function literal is added to a list, enclosing the range of
the loop body:

	var funcs []func()
	for _, item := range items {
		funcs = append(funcs, func() {
			fmt.Println(item)
		})
	}

Then the collected functions are called after the loop:

	for _, f := range funcs {
		f()
	}

The output will not be as expected:

    qux
    qux
    qux

Only the item is printed, which was referred to by the `item` variable in the
last iteration!

Therefore, a copy of the iteration variable must be stored in the scope of the
loop's body, so that the anonymous function can enclose it:

	var funcs []func()
	for _, item := range items {
		localItem := item // local copy, could also be called "item"
		funcs = append(funcs, func() {
            // encloses localItem, not the iteration variable
			fmt.Println(localItem)
		})
	}
	for _, f := range funcs {
		f()
	}

The output will now be correct:

    foo
    bar
    qux

### Variadic Function

The last function argument can be variadic and is a slice of the type defined:

    func sum(s ...int) int {
        var sum int
        for i := range s {
            sum += s[i]
        }
        return sum
    }

It can be called using zero to many parameters:

    sum()
    sum(1)
    sum(1, 2)
    sum(1, 2, 3)

An array can be passed by placing an ellipsis after it:

    numbers := []int{1, 2, 3, 4}
    sum(numbers...) // same as sum(1, 2, 3, 4)

These function types are _not_ equivalent:

    func f(...int) {}
    func f([]int) {}

### Deferred Function Calls

The `defer` keyword will postpone the execution of a function to its end:

    func main() {
        defer fmt.Println(", World!")
        fmt.Print("Hello")
    }

Output:

    Hello, World!

Deferred functions pile up on a stack, executing them in reverse order of
`defer` calls:

    func main() {
        onExit := func(message string) {
            fmt.Println(message)
        }

        defer onExit("nice")
        defer onExit("was")
        defer onExit("it")
    }

Output:

    it
    was
    nice

## Slices

Slices can be created with the `make` function, providing a length and a
optional capacity:

    s := make([]int, 3, 5) // len = 3, cap = 5
    s[0] = 1
    s[1] = 2
    s[2] = 3
    fmt.Println(len(s), cap(s)) // 3 5

A slice can grow up to its capacity using `append`:

    s = append(s, 4) // [1 2 3 4]
    fmt.Println(len(s), cap(s)) // 4 5

If the capacity is reached, the underlying array will be enlarged:

    s = append(s, 5)
    s = append(s, 6)
    fmt.Println(len(s), cap(s)) // 6 6

Slices can be copied using the `copy` function. Only as many entries will be
copied, as the target slice can hold with its capacity:

    a := []int{1, 2, 3}
    b := make([]int, 2)
    copy(b, a) // b = a
    fmt.Println(b) // [1 2]

## Maps

A Map stores key-value pairs. The keys must be comparable (`==` operator).

An empty `map` (`string` keys and `int` values) is created using the `make`
builtin function:

    m := make(map[string]int)

Entries can be added/changed by assignment:

    m["age"] = 31

Values can be accessed by its key (subscripting):

    age := map["age"] 

Trying to access non-existent entries returns the zero value of the value type:

    weight := map["weight"] // weight == 0

In order to distinguish between the default zero value from a zero value
actually contained in the list, a map subscription always returns an additional
`bool`, indicating whether or not the key used for retrieval is contained in
the map:

    pop := map[string]int{
        "Switzerland": 8,
        "Russia":      150,
        "Germany":     80,
    }
    germanPop, ok := map["Germany"] // ok == true, germapPop == 80
    frenchPop, ok := map["France"] // ok == false, frenchPop == 0

The returned `bool` value is often used in combination with an `if` statement:

    if pop, ok := pop["Switzerland"]; ok {
        // do something with pop
    }

Maps can created using a literal:

    m := map[string]int{"a": 1, "b": 2, "c": 3}

Any comparable type can be used as a map key. Slices and Maps, which are _not_
comparable, hence must not be used. However, their string representation can:

	netWorth := make(map[string]float64)
	kids := []string{"Bart", "Lisa", "Maggie"}
	parents := []string{"Homer", "Marge"}
	villains := []string{"Monty", "Fat Tony"}
	sliceToKey := func(s []string) string {
		return fmt.Sprintf("%v", s)
	}

	// storing
	netWorth[sliceToKey(kids)] = 2453.34
	netWorth[sliceToKey(parents)] = 12594.95
	netWorth[sliceToKey(villains)] = 1746239875.38

	// retrieving
	kidsWorth := netWorth[sliceToKey(kids)]
	parentsWorth := netWorth[sliceToKey(parents)]
	villainsWorth := netWorth[sliceToKey(villains)]

### Removing Entries

Map entries can be removed with the `delete` builtin function:

    age := map[string]int{
        "Bart":  10,
        "Lisa":  8,
        "Monty": 112,
    }
    delete(age, "Bart")

Attempts to delete by non-existant keys fail silently:

    delete(age, "Maggie") // nothing happens

## `if` Statement

TODO

### Combined `if` Statement

The `if` statement can be combined with a declaration and initialization, thus
removing the scope of the variable to the `if` block:

    if err := request.ParseForm(); err != nil {
        log.Fatal(err)
    }

## `continue` Statement

Jump to the next iteration of a loop:

    for i := 1; i < 10; i++ {
        if i % 2 == 0 {
            continue
        }
        fmt.Println(i)
    }

## `break` Statement

Leave the loop:

    i := 0
    for {
        if i == 10 {
            break
        }
        i++
    }

## Casting

Cast a byte slice to a string:

    s := string([]byte{65, 66, 67})
    fmt.Println(s) // ABC


## Constants

The `const` keyword defined a constant:

    const maxIndex = 255

Multiple constants can be combined to one declaration:

    const (
        firstIndex = 0
        lastIndex  = 255
    )

Constant declarations can appear at the package or function level.

If all constants are of the same type, it only must be declared for the first
constant:

    const (
        a int = 0
        b     = 1
        c     = 2
        d     = 3
    )

Constants belong to the group of basic data types like `int` or `float`, but
are not typed as strictly as variables in the terms of `int32` or `float64`.
The effective type is determined context-dependant upon compilation:

    const pi = 3.14
    var f32 float32 = pi
    var f64 float64 = pi
    fmt.Printf("%v %[1]T\n", f32) // 3.14 float32
    fmt.Printf("%v %[1]T\n", f64) // 3.14 float64

### Constant Generator `iota`

Grouped constants can be automatically initialized with ascending numbers
starting from 0 using `iota`:

    const (
        Sunday Weekday = iota
        Monday
        Tuesday
        Wednesday
        Thursday
        Friday
        Saturday
    )

`iota` can also be used for calculations:

    const (
        open int = iota * 1000 // 0 * 1000 = 0
        closed                 // 1 * 1000 = 1000
        pending                // 2 * 1000 = 2000
    )

## The `append` function

Add to a slice:

    s := []int{0, 1, 2}
    s = append(s, 2) // s == []int{0, 1, 2, 3}

## Composite Literals

### Array

    fib :=[5]int{1, 1, 2, 3, 5}
    fib :=[...]int{1, 1, 2, 3, 5}

### Slice

Unlike arrays, a slice literal doesn't need a size:

    fib := []int{1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89}

### Map

    pop := map[string]int{"Switzerland": 8, "Germany": 8, "Russia": 150}

### Struct

    type country struct {
        name       string
        population int
    }
    switzerland := country{name: "Switzerland", population: 8}

## Channels

Channels are created using the `make` builtin function, combined with the
`chan` keyword and with an according data type:

    ch := make(chan string)

Data is written to the channel using the arrow operator:

    ch <- "through the channel you go"

Data is read to che channel using the arrow operator, too:

    var str string
    str <- ch

## Go Routines

Any function call can be executed concurrently by preceding it with the `go`
keyword:

    foobar(foo, bar) // synchronous call
    go foobar(foo, bar) // asynchronuous call

## Mutex

A variable can be protected by a preceding mutex declaration:

    var mu sync.Mutex
    var count int

Any protected access to the variable must be surrounded by lock/unlock
instructions:

    mu.Lock()
    count++
    mu.Unlock()

## Switch

For multi-way branches, the `switch` statement is an option:

    switch resp.StatusCode {
        case 200:
            fmt.Println("OK")
        case 400:
            fmt.Println("client error")
        case 500:
            fmt.Println("server error")
        default:
            fmt.Println("something strange")
    }

There's no `break` needed to terminate the execution after a branch. The
`fallthrough` statement can be used to fall through to the next branch (a
tagless `switch` doesn't need an operand, it evaluates boolean expressions for
every case):

    switch {
        case i > 100:
            fmt.Println("bigger than hundred")
            fallthrough
        case i > 10:
            fmt.Println("bigger than ten")
            fallthrough
        case i > 1:
            fmt.Println("bigger than one")
    }

The `switch` statement can be combined with an initialization, limiting the
scope of the initialized variable to the `switch` block:

    switch i := rand.Intn(100); i {
        case 13:
            fmt.Println("what a coincidence")
        default:
            fmt.Println("whatever...")
    }


## Comments

Single-line comments start with `//` and span to the rest of the line:

    i++ // increment i

Multi-line comments start with `/*` and end with `*/`:

    /*
     * I wanted to delete this code.
     * But I was afraid.
     * i--
     */

## Pointers

Pointers are declared with an asterisk:

    var i int // normal variable
    var *p int // pointer variable

Pointers store the address of a variable, which can be obtained using the
ampersand (address-of operator):

    p = &i

The value can be assigned and used with the asterisk:

    fmt.Println(*p)
    *p = 3

## Type Declarations

New types can be defined based on existing types:

    type Celsius float32

This helps when methods should apply only for a custom type, not for the underlying general type:

    func (c Celsius) String() string {
        return fmt.Sprintf("%g°C", c)
    }

## Type Conversion

Every type `T` offers a conversion function `T()`:

    i := 100     // int
    j := int8(i) // int8

## Bitwise Operations

The bitwise right shift operator `>>` shifts the left-hand side integer
operator n bits to the right, n being the right-hand side integer operator.

    i := 15     // 15 decimal = 1111 binary
    j := i >> 1 // 7 decimal = 111 binary

The right shift applied to signed data types _will not_ shift the leftmost bit,
thus keeping the sign bit in place.

The bitwise and operator `&` performs the and operation bit by bit:

    i := 21     // 21 decimal = 10101 binary
    j := i & 19 // 10101 & 10011 = 10001 = 17 decimal

## Scope

A variable's scope is determined by its enclosing lexical block:

- universe: accessible everywhere
- package: accessible in the current package
- file: accessible in the current file
- for, if, switch, select: accessible within the body denoted by curly braces
- case: each case of a switch or select statement

### Scope Redeclaration

A declaration in a higher scope can be shadowed by a declaration in a lower scope:

    package main

    import "fmt"

    var s = "foo"

    func main() {
        s := "bar"
        if len(s) > 0 {
            s := "qux"
            fmt.Println(s) // qux
        }
        out()
        fmt.Println(s) // bar
    }

    func out() {
        fmt.Println(s) // foo
    }

## Basic Data Types

- Integer
    - Signed
        - `int8`
        - `int16`
        - `int32`/`rune` (for unicode code points)
        - `int64`
        - `int`: 32 or 64 bits (platform dependant)
    - Unsigned (mainly for bitwise operations)
        - `uint8`/`byte`
        - `uint16`
        - `uint32`
        - `uint64`
        - `uint`: 32 or 64 bits (platform dependant)
- Floating Point
    - `float32` (single precision)
        - biggest possible value: `math.MaxFloat32`
    - `float64` (double precision)
        - biggest possible value: `math.MaxFloat64`
- Complex Numbers
    - `complex64`
        - consists of two `float32` values
    - `complex128`
        - consists of two `float64` values
- Strings
    - `string` (UTF-8 encoded sequence of bytes, immutable)
    - `rune` (single unicode code point)

### Conversion

A integer division results in an integer result:

    10 / 3 // 3 int

If at least one `float64` operand is involved, the result becomes a `float64`:

    10 / 3.0   // 3.33333333333333335 float64
    10.0 / 3   // 3.33333333333333335 float64
    10.0 / 3.0 // 3.33333333333333335 float64

### Inf and NaN

Infinite numbers are indicated using positive or negative infinity:

    var z float64
    fmt.Println(+1 / z) // +Inf
    fmt.Println(-1 / z) // -Inf

Operations such as zero divided by zero or the square root of -1 result in a
"not a number" (`math.NaN`):

    var z float64
    fmt.Println(z / z)
    fmt.Println(math.Sqrt(-1))

The value `math.NaN` must not be used for comparisons, for it always results in
`false`. Use `math.IsNaN` instead:

    var z float64
    math.IsNaN(1.0 / z) // false
    math.IsNaN(z / 1.0) // false
    math.IsNaN(z / z) // true

### Complex Numbers

Create a complex number out of a real and imaginary part:

    var r float32
    var i float32
    c := complex(r, i) // 0+0i, complex64

    var r float64
    var i float64
    c := complex(r, i) // 0+0i, complex128

Extract the real and imaginary part:

    c := complex(3.0, 1.0)
    r := real(c) // 3.0
    i := imag(c) // 1.0

Create a complex number using a imaginary literal:

    c := 3 + 1i
    fmt.Printf("%v %[1]T\n", c) // (3+1i) complex128

### Strings

The type `string` is an immutable sequence of bytes, not of runes! Strings are UTF-8 encoded.

The `len` builtin function returns the number of bytes in a string:

    s := "Привет, мир!"
    fmt.Println(len(s)) // 21

Indices can be used to access the byte at a specific position:

    fmt.Println(s[12]) // 44 (the comma)

Strings are compared byte by byte.

A string can be converted to an array of runes:

    s := "hello"
    r := []rune(s)

An array of runes can be converted to a string:

    r := []rune{104, 101, 108, 108, 111}
    s := string(r) // "hello"

The `range` operator automatically decodes the UTF-8 encoded string, providing runes:

    s := "Привет, мир!"
    for i, r := range s {
        fmt.Printf("%2d: %c\n", i, r)
    }

     0: П
     2: р
     4: и
     6: в
     8: е
    10: т
    12: ,
    13:  
    14: м
    16: и
    18: р
    20: !

The indices are _not_ subsequent, but represent the start index of a rune in
the string's underlying byte array.

#### Raw Strings

Raw strings within backticks can be freely formatted and span over multiple lines:

    html := `<html>
        <head><title>Hello, World!</title></head>
        <body><h1>Hello, World!</h1></body>
    </html>`

They are often used for templates and regular expressions.

## Structs

Structs combine basic and and composite types to new composite types:

    type Person struct {
        Name    string
        Age     int
        Hobbies []string
    }

Struct variables can be initialized explicitly with member names listed in any
sequence:

    dilbert := Person{
        Name:    "Dilbert",
        Age:     42,
        Hobbies: []string{"Engineering"},
    }

Or implicitly, following the declaraion's sequence of members:

    wally := Person{"Wally", 49, []string{"Idling"}}

Structs are comparable, if _all_ of their members are comparable:

    type Animal struct {
        Name    string
        Legs    int
    }
    cat := Animal{"Pussy", 4}
    dog := Animal{"Woofy", 4}
    pig := Animal{"Pussy", 4}
    cat == dog // false (different name, same number of legs)
    cat == pig // true (same name, same number of legs)

If a struct variable is only to be used once, it can be defined ad-hoc:

    herbie := struct {
        Brand  string
        Wheels int
    }{
        "VW Beatle",
        4,
    }

If consecutive members are of the same type, the type only has to be stated
once:

    type Creature struct {
        Domain
        Kingdom
        Phylum
        Class
        Order
        Family
        Genus
        Species string
    }

The `#` adverb to the `%v` verb outputs the member names and the values of a
struct variable:

    fmt.Printf("%#v\n", dilbert)

### Structs and Pointers

Struct variables can be initialized as pointers:

    alice := &Person{
        Name:    "Alice",
        Age:     39,
        Hobbies: []string{"Scolding"},
    }
    fmt.Println(*alice) // accessing the value

Pointers can also be defined to members of a struct:

    dilbertsAge := &dilbert.Age
    fmt.Println(*dilbertsAge) // accessing the value

### Embedded Structs

Structs can consist of other structs:

    type Point struct {
        X int
        Y int
    }
    type Circle struct {
        Center Point
        Radius int
    }

The embedded struct can be defined in a distinct step:

    p := Point{13, 12}
    c := Circle{p, 20}

Or in a single step using nesting:

    c := Circle{Point{13, 12}, 20}

The struct's members can be accessed using a fully qualified path:

    fmt.Println(c.Center.X, c.Center.Y, c.Radius)

If a structs member is defined anonymously:

    type Circle struct {
        Point
        Radius int
    }

The path to the nested members can be omitted:

    fmt.Println(c.X, c.Y, c.Radius)

The member names have to be unique in the latter case, it would not be possible
to nest another struct anonymously with the member names X and Y.

### Encapsulation

A struct member beginning with a capital letter is exported, i.e. visible to
other packages.

A struct member beginning with a lower-case letter is not exported, i.e. only
visible inside the declaring package.

Considering this example:

    type Person struct {
        id   string
        Name string
        Age  int
    }

The field `id` is only visible from within `Person`'s declaring package,
whereas `Name` and `Age` are also visible from all other packages.

## Panic and Recover

If an error cannot be handled gracefully, a panic can be caused using the
`panic` builtin function, leaving the current control flow. The program will be
exited, unless a the program recovers from the panic using the builtin
`recover` function.

Causing a panic:

    func divide(a, b float64) float64 {
        if b == 0 {
            panic("cannot divide by zero")
        }
        return a / b
    }

Deferred functions will be executed after its calling function panicked. A
panickinig function can only be recovered from by invoking `recover` in a
deferred function call:

    func main() {
        defer func() {
            p := recover()
            fmt.Println(p)
        }()
        fmt.Println(divide(10, 0))
    }

Just like errors, panics are values that can be compared, stored, and wrapped
to be promoted by an additional `panic` call.

## Methods

Given the structure `Point` and the function `Distance`:

    type Point struct {
        X int
        Y int
    }

    func Distance(p, q Point) float64 {
        x := p.X - q.X
        y := p.Y - q.Y
        return math.Sqrt(float64(x*x + y*y))
    }

The function `Distance` can be rewritten as a method attached to the type Point:

    func (p Point) Distance(q Point) float64 {
        x := p.X - q.X
        y := p.Y - q.Y
        return math.Sqrt(float64(x*x + y*y))
    }

Technically, the _receiver_ `p` is just a parameter to the function. Therefore,
the implementation for a function and a method is the same, only the invocation
differs:

    func main() {
        p := Point{5, 3}
        q := Point{2, 1}
        fmt.Println(Distance(p, q)) // function call
        fmt.Println(p.Distance(q)) // method call
    }

Methods can be attache to any type defined in the same package. In order to add
a method to a type like `string` or `int`, a type alias can be defined:

    typedef Text string

    func (t Text) NumberOfNewLines() int {
        // ...
    }

### Pointer Receivers

Just like ordinary parameters, the _receiver_ can be passed in as a pointer,
avoiding copying the argument value upon invocation:

    func (p *Point) Distance(q *Point) float64 {
        // ...
    }

The receiver can be a pointer, but the underlying type of the receiver must not
be a pointer:

    type Amount *float64 // pointer type
    func (a Amount) format() string { } // illegal

The usage of pointers or values should be consistent; either _all_ methods of a
type use pointers, or _all_ methods of that type use values.

`nil` pointers (but not `nil` itself, which is untyped) are valid receiver
values, but must be dealt with and should be documented properly.

### Struct Embedding

If the struct `ColoredPoint` embeds `Point` anonymously:

    type Point struct { X, Y float64 }

    func (p Point) Distance(q Point) float64 {
        x := p.X - q.X
        y := p.Y - q.Y
        return math.Hypot(x, y)
    }

    type ColoredPoint struct {
        Point // anonymous, struct embedding
        Color color.RGBA
    }

The method `Distance` of `Point` is also appliable for `ColoredPoint`:

    red := color.RGBA{255, 0, 0, 255}
    blue := color.RGBA{0, 0, 255, 255}
    var p = ColoredPoint{Point{1, 1, red}}
    var q = ColoredPoint{Point{5, 4, blue}}

    d := p.Distance(q.Point)
    fmt.Println("distance =", d) // "distance = 5"

Notice that the receiver `p` is a `ColoredPoint`, but that the parameter `q`
must be a `Point`, not a `ColoredPoint`:

    p.Distance(q) // compile error, q is not a Point

### Method Values and Expressions

Just like functions, methods can be stored as values for later calls (method
values):

    origin := Point{0, 0}
    point := Point{3, 4}
    fromOrigin := origin.Distance
    fromOrigin(point) // 5

A reference to a method not related to a receiver is called a method reference:

    distance := Point.Distance

Because the receiver is unknown, it must be supplied as the first argument upon
invocation:

    distance(origin, point) // 5

If `Distance` were defined with the receiver `p *Point` instead of `p Point`,
the syntax would be slightly different:

    distance := (*Point).Distance
    distance(&origin, point)

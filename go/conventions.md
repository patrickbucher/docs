# Conventions

## `main` Package

A package with the name `main` declares a standalone program (as
compared to a library).

## `main()` Function

The function `main()` in the `main` package is the starting point of a
standalone program.

## `init()` Function

The function `init()` in every package is called upon the package's
initialization, before `main` that is.

    var i = 1
    var f = 1.1
    var s = "foo"

    func init() {
        i = 2
        f = 2.2
        s = "bar"
    }

    func main() {
        fmt.Println(i, f, s) // prints 2 2.2 bar
    }

## Braces

Opening Braces must not stand on a new line.

## Package Comments

A package is described by a comment of one or more sentences immediately
preceding the `package` declaration:

    // Package strings implements simple functions to manipulte UTF-8 encoded
    // strings.
    package strings

If the package consists of multiple file, only one file should contain the
package comment. This usually is the file with the name of the package itself
(`foobar` package: `foobar.go`). To keep the source file short and clean,
documentation can also be put into a file called `doc.go`.

The comment preceding the `main` package describes the program as a whole:

    // Echo prints its command-line arguments.
    package main

## Verbs for Formatted Output

The functions in the `fmt` package with a `f` at the end of their names support
formatted output using _verbs_:

- integers
    - `%d`: decimal integer, `10`
    - `%x`/`%X`: hexa-decimal integer, `af9832`/`AF9832`
    - `%o`: octal integer, `245243`
    - `%b`: binary integer, `10011010110`
- floating point numbers
    - `%f`: single precision float, `3.333333`
    - `%g`: double precision float, `3.3333333333333335`
    - `%e`: exponential representation, `3.333333e+00` (`3.333333 * 10^0`)
- boolean
    - `%t`: boolean, `true` or `false`
- text
    - `%c`: rune (unicode code point), `ç`
    - `%s`: string, `élément`
    - `%q`: quoted string (`"c'est quoi, ça?"`) or quoted rune (`'ç'`)
- miscellaneous
    - `%v`: value of an expression in natural format
        - `fmt.Println("%v", fmt.Println) // 0x47c070`
        - `fmt.Println("%v", 10/3.0) // 3.3333333333333335`
    - `%T`: type of an expression
        - `fmt.Println("%v", fmt.Println) // func(...interface {}) (int, error)`
        - `fmt.Println("%v", 10/3.0) // float64`
    - `%%`: literal `%`

### Adverbs

If an argument is needed twice:

    fmt.Printf("%v %T\n", 10/3, 10/3)

It can be reused using the `[1]` adverb:

    fmt.Printf("%v %[1]T\n", 10/3)

The adverb can deal with any positive number >0 within the arguments index
range.

The prefix of octal and hexadecimal numbers can be printed using the `#` adverb:

    fmt.Printf("%#o %#x %#X\n", 10, 10, 10)
    // 012 0xa 0XA

The two adverbs mentioned can be combined:

    fmt.Printf("%#o %#[1]x %#[1]X\n", 10)
    // 012 0xa 0XA

Integers can be right aligned using the width adverb:

    fmt.Printf("%6d\n", 1)
    fmt.Printf("%6d\n", 1000)
    fmt.Printf("%6d\n", 1000000)

Output:

          1
       1000
    1000000

Floating point number can be aligned using the width adverb. The first number
indicates  the overall width of the number to print, including the decimal
positions. The second number indicates the positions after the decimal point:

    fmt.Printf("%6.2f\n", 10/3.0)
    fmt.Printf("%6.2f\n", 10/3.0)
    fmt.Printf("%6.2f\n", 10/3.0)

Output:

        3.33
       33.33
      333.33

The `#` adverb to the `%v` verb outputs the member names and the values of a
struct variable:

    dilbert := struct {
        Name string
        Age  int
    } {
        "Dilbert",
        42,
    }
    fmt.Printf("%#v\n", dilbert)

Output:

    struct { Name string; Age int }{Name:"Dilbert", Age:42}

The `%*s` adverb can be used to right-pad a string. It requires two parameters:
the amount of indentation and the string to be padded:

    fmt.Printf("%*s", 0, "hello")
    fmt.Printf("%*s", 5, "hello")
    fmt.Printf("%*s", 8, "hello")

Output:

    hello
    hello
       hello

The first two lines are identical, becaue the length of "hello" is 5, and the
value is only visibly beeing right-padded when the indentation is bigger than
the string's length.

## Escape Sequences

- `\a`: alarm bell
- `\b`: backspace
- `\f`: form feed
- `\n`: new line
- `\r`: carriage return
- `\t`: tab
- `\v`: vertical tab
- `\'`: literal apostrophe (to express `'` within rune literals: `'\''`)
- `\"`: literal double quotation mark (to express `"` within string literals:
  `"\""`)
- `\\`: literal backspace
- `\xhh`: hexadecimal number (`'\xff'`)
- `\ooo`: octal number (`'\377'`)
- `\uhhhh`: unicode code point (16 bit)
- `\Uhhhhhhhh`: unicode code point (32 bit)

## Naming

### Exported Names

Names starting with a capital letter are exported, others not:

    type Person struct {
        Firstname   string  // exported
        Lastname    string  // exported
        identity    int     // not exported
    }

Exported names can be accessed from other packages, whereas only the declaring
package can access unexported names.

Instead of writing "getter" and "setter" methods for unexported fields, the
`get` prefix is omitted in Go:

    // "get" omitted
    func (p *Person) Identity() {
        return p.identity
    }

    // "set" retained
    func (p *Person) SetIdentity(identity string) {
        p.Identity = identity
    }

### Camel Case

Go identifiers are written in CamelCase:

    var yearOfBirth, durationInMillis int   // good
    var year_of_birth, duration_in_milis    // bad

Acronyms should be spelled in all capitals:

    var exportedToHTML bool // good
    var exportedToHtml bool // bad

## Import Path

The import path `org.acme/encabulator` is looked up in the directory
`$GOPATH/src/org.acme/encabulator`

## UTF-8

Strings are encoded in UTF-8. A unicode code point can be represented from one
byte (ASCII) up to four bytes. The first byte starts with the sequence `0` (one
byte), `11` (two bytes), `110` (three bytes) or `1110` (four bytes). Each
subsequent byte starts with `10`.

    0xxxxxxx                                from     0 to      127 (ASCII)
    11xxxxxx 10xxxxxx                       from   128 to     2047
    110xxxxx 10xxxxxx 10xxxxxx              from  2048 to    65535
    1110xxxx 10xxxxxx 10xxxxxx 10xxxxxx     from 65536 to 0x10ffff

## Error Handling

### Return Values

In the parameter list of a function with multiple return values, an error
should be the last item:

    func foo(a, b int) (error, int) {} // bad
    func foo(a, b int) (int, error) {} // bad

If the function doesn't return an error, but indicates success with a boolean
return value (like map lookup does), that variable is commonly called "ok" --
both by the function and the caller:

    func lookup(m map[string]string, k string) (value string, ok bool) { }
    // ...
    value, ok := lookup(m, "foobar")

### Error Messages

Error messages should be chained in all lowercase in order to provide the
caller with a complete but concise breakdown of what went wrong:

    if resp, err := http.Get(url); err != nil {
        return fmt.Errorf("get %s: %v", url, err)
    }

Output:

    $ go run httpget.go http://foobar.ch
    get http://foobar.ch: Get http://foobar.ch: dial tcp: lookup foobar.ch: no such host

### Error Handling Strategies

1. Propagate the error -- with or without wrapping -- if there's nothing the
   program can do to recover _on the level where the error occured_.
    - Example: A function performs an HTTP GET request to a certain resource,
      which fails. It's up to the caller to decide how to handle that outcome.
2. Retry later -- consider exponential back-off -- if an external resource
   could be temporarily unavailable.
    - Example: A resource is sent to a server for processing. Due to the lack
      of status indication, polling is the only way to find out whether or not
      the result is ready.
3. Exit the program, if further execution after the error is pointless.
    - Example: A program to extract hyperlinks from a given URL cannot do
      anything useful, if the initial request to the URL indicated fails.
4. Log the error and ignore it; sometimes things are allowed to fail.
    - Example: A web crawler might stumble upon dead hyperlinks. If those
      cannot be accessed, it is useful to know (to avoid further tries), but
      the program can continue.
5. Ignore the error completely -- but document it!
    - Example: A program stores files in the operating system's temp folder and
      fails to delete those after its work is done. If that program runs on a
      machine that is regularly restarted, the temp folder will be cleaned up
      sooner or later anyway, so the error can be ignored. The omission should
      be documented, however, because the program might be used in a different
      setup, where temp folders aren't cleaned up on a regular basis.


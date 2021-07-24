# Tooling

## `go run`

Compile and run a Go program:

    go run helloworld.go

## `go build`

Compile a Go program:

    go build helloworld.go

## `go doc`

Lookup the documentation for a package:

    go doc http

Lookup the documentation for a function within a package:

    go doc http.Get

Lookup a builtin symbol:

    go doc builtin/error

## `go fmt` and `gofmt`

- `go fmt` re-formats all the files in a package
- `gofmt` re-formats the given files and offers diagnostic options

## `goimports`

Organizes -- adds missing, removes unnecessary, orders in alphabetical order --
imports in a package.

## `go get`

Get the package `golang.org/x/net/html`:

    go get golang.org/x/net/html

## `go test`

Run the tests of the current package:

    go test

Run the tests with test coverage:

    go test -cover

Store the coverage (activates the `cover` flag implicitly):

    go test -coverprofile=coverage.out

Display a HTML report for the coverage:

    go tool cover -html=coverage.out 

Store the coverage report instead of opening it:

    go tool cover -html=coverage.out -o=coverage.html

Run the benchmarks (matching the pattern `.`, thus any benchmark):

    go test -bench=.

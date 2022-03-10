# Go Modules

- for Go 1.13 and later, do **not** set `GO111MODULE` to use Go modules
- package = Go files in a directory, compiled together
- modules = related Go packages, released together
- a Go repository usually contains one module
- go mod init my/stupid/example
- go mod install my/stupid/example
- go commands work relative to the working directory

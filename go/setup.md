# Setup

Install Go on Arch Linux:

    # pacman -S go

## Environment Variables

### GOROOT

Go's installation directory:

    export GOROOT='/usr/lib/go'

### GOPATH

The directory containing Go code:

    export GOPATH="$HOME/go"

Make sure to have the following folders in `$GOPATH`:

- `src`: source code
- `bin`: binaries
- `pkg`: packages

```bash
mkdir -p $HOME/go/src
mkdir -p $HOME/go/bin
mkdir -p $HOME/go/pkg
```

### PATH

Add Go binaries to the PATH variable:

    export PATH="$PATH:$GOPATH/bin"

## `vim-go`

Configure `.vimrc` for `vim-plug`:

    call plug#begin('~/.vim/plugged')
    Plug 'fatih/vim-go'
    call plug#end()

Run `:PlugInstall` in vim after re-opening with new `.vimrc`.

Suggested configuration in `.vimrc` (format upon saving using `goimports`):

    let g:go_fmt_autosave = 1
    let g:go_fmt_command = "goimports"

Install the binaries for `vim-go`:

    :GoInstallBinaries

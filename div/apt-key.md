The key EF8D349F is available:

```bash
$ test $(apt-key export EF8D349F 2>/dev/null | wc -c) -ne 0
$ echo $?
0
```

The key EF8D349F is _not_ available:

```bash
$ test $(apt-key export EF8D349F 2>/dev/null | wc -c) -ne 0
$ echo $?
1
```

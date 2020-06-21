# SPIL demo projects

[SPIL interpreter github page](https://github.com/avoronkov/spil)

## Installation

- Install SPIL interpreter first:
```console
$ go get github.com/avoronkov/spil
```

- Make sure that `$GOPATH/bin` is in `$PATH`.

## Demo projects

### fractal-drawer

- Build drawer plugin:
```console
$ cd fractal-drawer/lib/drawer
$ go build --buildmode=plugin
```

- Check some examples:
```console
$ cd fractal-drawer
$ ./main.lisp examples/koch-snowflake.txt
fractal is stored in examples/koch-snowflake.txt.png
```

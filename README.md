# haskell-foreign-library-example

This is a repository for experimenting with `foreign-library` feature of GHC.

## Usage with `stack`

```
$ stack build
$ stack exec -- gcc test.c -Ilib -L$(stack path --local-install-root)/lib -lexample -o test
```

macOS:
```
$ install_name_tool -add_rpath $(stack path --local-install-root)/lib test
$ ./test
```

Linux:
```
$ export LD_LIBRARY_PATH=$(stack path --local-install-root)/lib:$LD_LIBRARY_PATH
$ ./test
```

Windows (MINGW):
```
$ export PATH=$(cygpath -u $(stack path --local-install-root))/lib:$PATH
$ ./test
```

## Usage with `cabal-install`

```
$ cabal build
$ cabal exec -- gcc test.c -Ilib -L$(dirname $(cabal list-bin example)) -lexample -o test
```

macOS:
```
$ install_name_tool -add_rpath $(dirname $(cabal list-bin example)) test
$ ./test
```

Linux:
```
$ export LD_LIBRARY_PATH=$(dirname $(cabal list-bin example)):$LD_LIBRARY_PATH
$ ./test
```

Windows (MINGW):
```
$ export PATH=$(cygpath -u $(dirname $(cabal list-bin example))):$PATH
$ ./test
```

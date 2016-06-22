gp - simplified, readable grep with contextual excludes
=======================================================
**gp** is a simplified **grep** with contextual excludes. It reduces keystrokes and makes results easier to read.

### Contextual excludes

gp makes it easy to specify multiple excludes for directories and files and to do so on a per-project basis. It does this by reading excludes from `./.gp_exclude` and `$HOME/.gp_exclude_global`. For example, if the following were the content of the exclude files:

```
# ./.gp_exclude
resources/
test.py
```

```
# $HOME/.gp_exclude_global
node_modules/
```

The command `gp foo` would execute:

```
grep -ir --color --exclude-dir=resources --exclude-dir=node_modules --exclude=test.py foo .
```

### Simplified usage

gp defaults to recursive, case-insensitive grep in the current working directory. Rather than use

```
grep -ir foo .
```

use

```
gp foo
```

### Easier-to-read results

gp prettifies results by always using `--color` and printing a full terminal-width line before results.

### Arguments
To see the grep command that would otherwise be executed, use `--echo` as the first argument:
```
$ gp --echo foo
grep -ir --color --exclude-dir=resources --exclude-dir=node_modules --exclude=test.py foo .
```

To delegate directly to grep, use `--raw`:
```
gp --raw -r foo .
```

will execute

```
grep -r --color --exclude-dir=resources --exclude-dir=node_modules --exclude=test.py foo .
```

Installation
============
Please read [INSTALL](INSTALL.md) for installation instructions.

# ZSH Aliases

## Table of Contents

  - [aprint](#aprint)
  - [bulk](#bulk)
  - [eno](#eno)
  - [follow](#follow)
  - [gui](#gui)
  - [gsub](#gsub)
  - [gx](#gx)
  - [gxh](#gxh)
  - [pdf](#pdf)
  - [samefile](#samefile)
  - [sameln](#sameln)
  - [strc](#strc)
  - [strr](#strr)
  - [strs](#strs)
  - [uncp](#uncp)
  - [unmkdir](#unmkdir)
  - [unmv](#unmv)
  - [undo](#undo)
  - [update](#update)
  - [venv](#venv)

## [aprint](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.system#L6-L20)
Print contents of alias function

## [bulk](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.file#L15-L79)
Convenient and safe wrapper for `find` utilizing piped commands

## [eno](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.system#L23-L26)
Display error number of last command

### Example usages

- Run invalid or unknown command
```shell
invalid_cmd
eno  # prints "EKEYEXPIRED 127 Key has expired"
```

- Run valid command
```shell
echo "lol"
eno  # prints nothing
```

## [follow](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.file#L82-L85)
Change current working directory to the last directory a file or directory was copied or moved to via `cp` or `mv`

### Example usages

- Copy file to a different directory

```shell
pwd  # prints "/current/path"
cp file1 /different/path
follow
pwd  # prints "/different/path"
```

- Rename file in the same directory

```shell
pwd  # prints "/current/path"
mv file1 file2
follow
pwd  # prints "/current/path"
```

## [gui](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.file#L88-L90)
Run `xdg-open` on path

### Example usages

- Open current directory in default file viewer application
```shell
gui
```

- Open PNG image in default image viewer application
```shell
gui /path/to/image.png
```
- Open URL in default browser application
```shell
gui https://www.google.com/
```

## [gsub](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.gitx#L6-L10)
Update Git submodule

## [gx](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.gitx#L13-L19)
Remove all files in gitignore

## [gxh](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.gitx#L22-L29)
Remove all untracked files and directories

## [pdf](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.file#L93-L95)
Open a PDF file with the Evince viewer

## [samefile](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.file#L98-L100)
Compare 2 files to check if they have the same contents

### Example usages

- Compare 2 files with identical content
```shell
samefile file1 file2  # prints "file1 and file2 are the same file"
```

- Compare 2 files with different content
```shell
samefile file1 file2  # prints "file1 and file2 are different"
```

## [sameln](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.file#L103-L107)
Compare 2 files to check if they are linked

### Example usages

- Compare 2 identical links
```shell
sameln file1 file2  # prints "file1 and file2 are links (Inode: 1234)"
```

- Compare 2 different links
```shell
sameln file1 file2  # prints "file1 and file2 are not links"
```

## [strc](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.string#L6-L8)
Recursively count occurrences of string on all files in path

### Example usages

- Count occurrences of `coolstring`
```shell
$ pwd
/current/directory

$ cat file1
coolstring
blahblahblah

$ cat file2
fnskdjfnksjdnfkjsdnf

$ cat dir1/file3
coolstring
uncoolstring
yadayadayada

$ strc coolstring
dir1/file3:2
file1:1

$ strc coolstring dir1
dir1/file3:2

$ strc coolstring dir1/file3
2

$ strc unknown
String not found
```

## [strr](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.string#L11-L34)
Recursively replace string on all files in path

```shell
$ pwd
/current/directory

$ cat file1
coolstring
blahblahblah

$ cat file2
fnskdjfnksjdnfkjsdnf

$ cat dir1/file3
coolstring
uncoolstring
yadayadayada

$ strr coolstring hotstring

./file1:
coolstring >>> hotstring
./dir1/file3:
coolstring >>> hotstring
uncoolstring >>> unhotstring
Apply changes [Y/n]? y

$ cat file1
hotstring
blahblahblah

$ cat file2
fnskdjfnksjdnfkjsdnf

$ cat dir1/file3
hotstring
uncoolstring
yadayadayada
```

## [strs](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.string#L37-L39)
Recursively search string on all files in path

- Find occurrences of `coolstring`
```shell
$ pwd
/current/directory

$ cat file1
coolstring
blahblahblah

$ cat file2
fnskdjfnksjdnfkjsdnf

$ cat dir1/file3
coolstring
uncoolstring
yadayadayada

$ strs coolstring
file1:1:coolstring
file1-2-blahblahblah
--
dir1/file3:1:coolstring
dir1/file3:2:uncoolstring
dir1/file3-3-blahblahblah

$ strs coolstring dir1
dir1/file3:1:coolstring
dir1/file3:2:uncoolstring
dir1/file3-3-blahblahblah

$ strs coolstring dir1/file3
1:coolstring
2:uncoolstring
3-blahblahblah

$ strs unknown
String not found
```

### Example usages

- Compare 2 files with different content
```shell
samefile file1 file2  # prints "file1 and file2 are different"
```

## [uncp](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.file#L110-L144)
Undo `cp`

### Example usages

```shell
cp file1 file2
uncp  # removes file2

cp file1 /different/path
uncp  # removes /different/path/file2

cp file1 /different/path
uncp  # removes /different/path/file2
uncp  # reruns "cp file1 /different/path"
uncp  # re-removes /different/path/file2
```

## [unmkdir](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.file#L147-L167)
Undo `mkdir`

### Example usages

```shell
mkdir dir1
unmkdir  # removes dir1

mkdir dir1 dir2
unmkdir  # removes dir1 dir2

mkdir dir1 dir2
unmkdir  # removes dir1 dir2
unmkdir  # reruns "mkdir dir1 dir2"
unmkdir  # re-removes dir1 dir2
```

## [unmv](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.file#L170-L192)
Undo `mv`

### Example usages

```shell
mv file1 file2
unmv  # moves file2 to file1

mv file1 /different/path
unmv  # moves file2 to /different/path/file1

mv file1 /different/path
unmv  # moves file2 to /different/path/file1
unmv  # reruns "mv file1 /different/path"
unmv  # re-moves file2 to /different/path/file1
```

## [undo](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.file#L195-L211)
Undo last undo-able command

### Example usages

```shell
mv file1 file2
undo  # moves file2 to file1

mkdir dir1 dir2
undo  # removes dir1 dir2
undo  # reruns "mkdir dir1 dir2"
undo  # re-removes dir1 dir2

cp file1 /different/path
undo  # removes /different/path/file2
```

## [update](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.system#L29-L37)
Chain apt update and clean commands and refresh alias links

## [venv](https://github.com/sabbirahm3d/dotfiles/blob/master/zsh/.aliases/.file#L214-L224)
Set up a Python virtual environment

### Example usages

- Set up and activate virtual environment
```shell
ls -a  # .venv does not exist
venv
```

- Activate virtual environment
```shell
ls -a  # .venv exists
venv  # activate virtual environment
```

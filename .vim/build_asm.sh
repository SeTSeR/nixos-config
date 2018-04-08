#!/bin/bash

if [ $# -ne 1 ]; then
   echo "Usage: build_asm.sh <asm-file-name>"
   exit;
fi

name=${1%.*}

if [ $name = $1 ]; then
   echo "You must use file extension!"
   exit;
fi

osname=`uname -s`
if [ $? -ne 0 ]; then
    exit;
fi

c_temp=/tmp/_asm_build_$$.c
o_temp=/tmp/_asm_build_$$.o

if [ $? -ne 0 ]; then
    exit;
fi

case `echo $osname | tr [:upper:] [:lower:]` in
*cygwin*)
    systype=CYGWIN
    objformat=win32
    ;;
*linux*|*freebsd*)
    systype=UNIX
    objformat=elf32
    ;;
*darwin*)
    systype=DARWIN
    objformat=macho32
    ;;
*)
    echo "Not supported OS $osname"
    exit 1
    ;;
esac

echo '#include <stdio.h>' >> $c_temp
echo 'FILE *get_stdin(void) { return stdin; }' >> $c_temp
echo 'FILE *get_stdout(void) { return stdout; }' >> $c_temp

gcc -x c $c_temp -c -g -o $o_temp -m32
nasm -g -f $objformat $1 -o $name.o -D$systype
if [ $? -ne 0 ]; then
    rm -f $c_temp $o_temp $name.o
    exit;
fi

gcc $name.o $o_temp -g -o $name -m32
rm -f $c_temp $o_temp $name.o



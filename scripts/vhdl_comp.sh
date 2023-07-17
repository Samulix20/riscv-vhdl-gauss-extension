#!/bin/bash

rm -rf build
mkdir -p build/work

cd src
src_files=$(find -name "*.vhd")
hdr_files=$(echo "$src_files" | grep -E "pkg")
src_files=$(echo "$src_files" | grep -vE "pkg")

err=$(ghdl -a -Wc,-O2 -Wa,-O2 --workdir=../build/work $hdr_files $src_files 2>&1)
if [[ $? != 0 ]]
then
    echo "$err"
    exit 1
fi

err=$(ghdl -e -Wc,-O2 -Wa,-O2 --workdir=../build/work --ieee=synopsys -fexplicit "test" 2>&1)
if [[ $? != 0 ]]
then
    echo "$err"
    exit 1
fi

mv "test" "../build/riscv"
rm e~*.o
cd ..
rm -rf build/work
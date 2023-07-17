#!/bin/bash

cd build

while getopts ":t:w:" options; do

    case $options in
        t)
            STOP_T="--stop-time=${OPTARG}"
            ;;
        w)
            OUTPUT="--wave=${OPTARG}"
            ;;
        :)
            exit 1
            ;;
        *)
            exit 1
            ;;
    esac
done

if [ -z $OUTPUT ]
then
    ./riscv $STOP_T --unbuffered | python -u ../scripts/term.py 2> /dev/null
else
    ./riscv $STOP_T $OUTPUT
fi



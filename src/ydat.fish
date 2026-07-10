#!/usr/bin/fish

set -g str "+%Y%m%d-%HH"

function _help
    echo "usage: ydate [option]"
    echo ""
    echo "    Print today's time like this."
    echo "        20260406-22H"
    echo "    for file naming."
    echo ""
    echo "    Options:"
    echo "        -d"
    echo "            Insert hyphens between year and month and between month and day."
    echo "        -H"
    echo "            Doesn't print hours."
    echo "        -m"
    echo "            Add minutes at the end."
    echo "        -t"
    echo "            Use HH:MM:SS"
    echo "        -T"
    echo "            Replace - separating time and date by a T"
    echo "        -y"
    echo "            Replace 2026 by 26 for year."
    echo "        -h, --help"
    echo "            Print this help"
    echo ""
    echo "        Options can't be concatenated."
    echo "          X ydate -mt"
    echo "          O ydate -m -t"
    exit 0
end

function _opt
    for c in (string split -- '' (string sub -s 2 -- $argv[1]))
        switch $c
        case d
            set -g str (string replace --  '%Y%m%d' '%Y-%m-%d' $str)
        case H
            set -g str (string replace -r -- '(T|-)%H.*' '' $str)
        case m
            set -g str "$str%m"
        case t
            set -g str (string replace -r -- '%H.*' '%T' $str)
        case T
            set -g str (string replace -r -- '%d-' '%dT' $str)
        case y
            set -g str (string replace -- '%Y' '%y' $str)
        case h
            _help
        case '*'
            echo "ydate: Unknown option: $i" >&2
            exit 2
        end
    end
end

for arg in $argv
    switch $arg
    case --help
        _help
    case '-*'
        _opt $arg
    case '*'
        echo "ydate: Unvalid argument: $arg" >&2
        exit 1
    end
end

date $str
exit $status

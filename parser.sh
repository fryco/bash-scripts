#!/usr/bin/env bash
SCRIPT_AUTHOR="John Novak"
SCRIPT_VERSION=1.0
SCRIPT_DATE=1.1.1970
SCRIPT_NAME=$(echo ${0##*/})

script_main_func()
{
    echo $example_value
    echo $example_bool
}

show_help()
{
	echo "### $SCRIPT_NAME user manual"
    echo
    echo "NAME:"
    echo "  $SCRIPT_NAME"
    echo
    echo "SYNOPSIS:"
    echo "  ./$SCRIPT_NAME [ARGUMENTS]"
    echo
    echo "DESCRIPTION:"
    echo "  CLI arg parser demo script. It contains examples for boolean flag and also "
    echo "  for argument with value."
    echo
    echo "ARGUMENTS:"
    echo "  -ex value, --example value  set example param with value"
    echo "  -h,  --help                 show user commands"
    echo "  -sb, --set-boolean          set example boolean param"
    echo "  -v,  --version              show credentials"
}

show_credentials()
{
    echo "NAME: $SCRIPT_NAME, VERSION: $SCRIPT_VERSION, AUTHOR: $SCRIPT_AUTHOR, LAST UPDATE: $SCRIPT_DATE"
}

example_value=''
example_bool=false
skip_arg=false


if [[ 0 -eq $# ]]; then
    show_help
fi
for arg in "$@"; do
    if $skip_arg; then 
        skip_arg=false
        continue
    fi
    case "$arg" in
        -ex|--example)
            var_name="${1}"
            shift
            if [[ "$1" != "" ]]; then
                example_value="${1}"
                shift
                skip_arg=true
            else
                echo "ERR: value missing for $var_name argument"
                exit 1
            fi
            ;;
        -h|--help)
            show_help
            shift
            exit 0
            ;;
        -v|--version)
            show_credentials
            shift
            exit 0
            ;;
        -sb|--set-boolean)
            example_bool=true
            shift
            ;;
        -*)
            echo "ERR: invalid argument: $1"
            shift
            exit 1
            ;;
    esac
done

script_main_func

#!/usr/bin/env bash
SCRIPT_AUTHOR="John Novak"
SCRIPT_VERSION=1.1
SCRIPT_DATE=1.1.1970
SCRIPT_NAME=$(echo ${0##*/})

script_main_func()
{
    check_input_args
    echo $example_value
    echo $example_value2
    echo $example_bool
}

### If you want to have mandatory arguments add here condition to check if they
### are properly populated
check_input_args()
{
    ### Each flag, which needs to be verified has to have its own following block
    ### of code. Copy&paste&adjust it for all necessary 
    ### Begin block
    looking_for=$example_value
    valid_values=(one two three)
    if [ -n "$looking_for" ]; then
        is_valid=false
        for elem in ${valid_values[@]};
        do
            if [ "$elem" == "$looking_for" ]; then
                is_valid=true
                break
            fi
        done

        if  [ $is_valid = false ]; then 
            echo "ERR: Invalid value detected ($looking_for)"
            exit 1
        fi
    else
        echo "ERR: Missing mandatory flag: example"
        exit 1
    fi
    ### End block
    looking_for=$example_value2
    valid_values=(four five six)
    if [ -n "$looking_for" ]; then
        is_valid=false
        for elem in ${valid_values[@]};
        do
            if [ "$elem" == "$looking_for" ]; then
                is_valid=true
                break
            fi
        done

        if  [ $is_valid = false ]; then 
            echo "ERR: Invalid value detected ($looking_for)"
            exit 1
        fi
    else
        echo "ERR: Missing mandatory flag: example2"
        exit 1
    fi

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

example_value=""
example_value2=""
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
        -ex2|--example2)
            var_name="${1}"
            shift
            if [[ "$1" != "" ]]; then
                example_value2="${1}"
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

#!/bin/bash
# Exit the script immediately, if any command returns a non-zero status
set -e

# Credentials
SCRIPT_AUTHOR="John Novak"
SCRIPT_VERSION=1.0
SCRIPT_DATE=1.1.1970
SCRIPT_NAME=$(echo ${0##*/})

# Font decorators
color_RED=$(tput setaf 1)
color_GREEN=$(tput setaf 2)
color_YELLOW=$(tput setaf 3)
color_BLUE=$(tput setaf 4)
color_MAGENTA=$(tput setaf 5)
color_CYAN=$(tput setaf 6)
color_RESET=$(tput sgr0)

# Debug logs. Not covered by log filtering. Enabled via LOG_DEBUG flag
LOG_DEBUG=true

# Define logging level
# 0 - no logs
# 1 - error only
# 2 - error + good
# 3 - error + good + warning
# 4 - error + good + warning + info
# 5 - all logs
LOG_LEVEL=5

script_main_function()
{
    print "I am simple log"
    print_error "OMG! It's not working!"
    print_ok  "AWESOOOME! Seems legit"
    print_warning "I feel sick..."
    print_info "Let me sing a song of my people"
    print_debug "It not working yet"

}

# Print functions. Support different types of logs and filtering via LOG_LEVEL variable
print_error()
{
    local message=${@:?[${FUNCNAME[0]}] Must provide any string}
    if (( (5 >= $LOG_LEVEL) && (1 <= $LOG_LEVEL) )); then
        echo "${color_RED}[ERRO]${color_RESET} ${message}"
    fi
}

print_ok()
{
    local message=${@:?[${FUNCNAME[0]}] Must provide any string}
    if (( (5 >= $LOG_LEVEL) && (2 <= $LOG_LEVEL) )); then
        echo "${color_GREEN}[GOOD]${color_RESET} ${message}"
    fi
}

print_warning()
{
    local message=${@:?[${FUNCNAME[0]}] Must provide any string}
    if (( (5 >= $LOG_LEVEL) && (3 <= $LOG_LEVEL) )); then
        echo "${color_YELLOW}[WARN]${color_RESET} ${message}"
    fi
}

print_info()
{
    local message=${@:?[${FUNCNAME[0]}] Must provide any string}
    if (( (5 >= $LOG_LEVEL) && (4 <= $LOG_LEVEL) )); then
        echo "${color_CYAN}[INFO]${color_RESET} ${message}"
    fi
}

print()
{
    local message=${@:?${FUNCNAME[0]} Must provide any string}
    if ((5 == $LOG_LEVEL)); then
        echo "[    ] ${message}"
    fi
}

print_debug()
{
    local message=${@:?${FUNCNAME[0]} Must provide any string}
    if ((true == $LOG_DEBUG)); then
        echo "${color_MAGENTA}[DEBG]${color_RESET} ${message}"
    fi
}

script_main_function

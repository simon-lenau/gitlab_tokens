#!bash

# =========================== > make_declaration < =========================== #
function make_declaration {
    varname="${1}"
    if [ -z ${varname} ]; then
        return 0
    fi
    shift
    varval=("$@")
    echo \
        "local " \
        "${varname}=(" \
        $(printf "'%s' " ${varval[@]}) \
        ")"
}
# ────────────────────────────────── <end> ─────────────────────────────────── #

# =========================== > parse_arguments < ============================ #

# ┌┌────────────────────────────────────────────────────────────────────────┐┐ #
# ││ `parse_arguments()`                                                    ││ #
# ││                                                                        ││ #
# ││ Parse arguments to assign them inside a function                       ││ #
# ││                                                                        ││ #
# ││ Input:                                                                 ││ #
# ││ $1 : valid_args (array): Array of valid arguments                      ││ #
# ││ $2... : arguments: Arguments of form                                   ││ #
# ││ -key=value / --key=value / -key value / --key value                    ││ #
# ││                                                                        ││ #
# ││ Output:                                                                ││ #
# ││ Assignment statements of form key="value"                              ││ #
# ││ Usage:                                                                 ││ #
# ││ parse_arguments <valid_args> <arg2> ... <argn>                         ││ #
# ││                                                                        ││ #
# ││ Examples:                                                              ││ #
# ││ valid_args=("key1" "key2")                                             ││ #
# ││ function test {                                                        ││ #
# ││ eval "$(parse_arguments valid_args[@] -key1 val1 --key2=val2)"         ││ #
# ││ echo "key1: $key1"                                                     ││ #
# ││ echo "key2: $key2"                                                     ││ #
# ││ }                                                                      ││ #
# └└────────────────────────────────────────────────────────────────────────┘┘ #

function parse_arguments {
    declare -A arg_array
    argname=""
    argval=""
    if [ "${#args[@]}" -gt "0" ]; then
        for ((i = 0; i < ${#args[@]}; i++)); do
            arg_array["${args[$i]}"]="${argdefault[$i]}"
        done
    fi
    i=0
    while [[ $# -gt "0" ]]; do
        case "$1" in
        --*=* | -*=*) # for arguments like --a=5
            ((i++))
            if [ "$i" -gt "1" ]; then
                arg_array["$argname"]="${argval[@]}"
            fi
            argname="${1%%=*}"
            argname="${argname#--}"
            argname="${argname#-}"
            argval=("${1#*=}")
            ;;
        --* | -*) # for arguments like --a 5
            ((i++))
            if [ "$i" -gt "1" ]; then
                arg_array["$argname"]="${argval[@]}"
            fi
            argname="${1}"
            argname="${argname#--}"
            argname="${argname#-}"
            argval=("${2}")
            shift
            ;;
        *)
            argval+=("$1")
            if [ -z "${argname}" ]; then
                echo "err \"Invalid unnamed argument to \\\`${FUNCNAME[@]:1:1}\\\`: '${1}'\" \
                    \"Valid arguments names are: $(printf "\'%s\' " "${args[@]}")\";return 1"
            fi
            ;;
        esac
        shift
    done

    if [ ! -z "$argname" ]; then
        arg_array["$argname"]="${argval[@]}"
    fi

    # Check if all arguments are valid
    for argname in ${!arg_array[@]}; do
        if [[ ! " ${args[@]} " =~ " ${argname} " ]]; then
            echo "err \"Invalid argument to \\\`${FUNCNAME[@]:1:1}\\\`: '${argname}'\" \
                    \"Valid arguments names are: $(printf "\'%s\' " "${args[@]}")\";return 1"

            ((check++))
            return 1
        fi
    done

    for argname in ${!arg_array[@]}; do
        make_declaration "${argname}" "${arg_array[${argname}]}"
    done

}
# ────────────────────────────────── <end> ─────────────────────────────────── #

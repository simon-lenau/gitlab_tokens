#!bash
source $(dirname "${BASH_SOURCE[0]}")/../init

function example_function {
    init_doc
    init_desc \
        "This is an" \
        "Example function"
    init_arg "int" "int_arg" "This is some int argument" "default_int"
    init_arg "str" "str_arg" "This is some string argument" "default_str"

    need_help $@ && return $?

    eval "$(parse_arguments "$@")"

    echo "int_arg: ${int_arg[@]}"
    echo "str_arg: ${str_arg[@]}"

}

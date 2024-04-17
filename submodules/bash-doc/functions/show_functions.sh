function show_help {
    local func_name="${FUNCNAME[@]:2:1}"
    local len_args=8
    local len_types=0
    for ((i = 0; i < ${#args[@]}; i++)); do
        len_args=$(max $len_args ${#args[$i]})
        len_types=$(max $len_types ${#argtype[$i]})
    done
    len_args=$((len_args + 1))
    len_types=$((len_types + 3))

    # Print

    # Function Name
    indent 0
    format_func_name "${func_name}"
    indent +
    # Function description
    if [ "${#funcdesc[@]}" -gt "0" ]; then
        for ((i = 0; i < ${#funcdesc[@]}; i++)); do
            newline 1 &&
                indent &&
                format_func_desc "${funcdesc[$i]}"
        done
    fi
    newline 2 && indent 0
    # Function arguments
    if [ "${#args[@]}" -gt "0" ]; then
        indent +
        fmt_help --type="header" "Arguments:"
        indent +
        __bash_doc_arg_indent__=${__bash_doc_indent__}
        for ((i = 0; i < ${#args[@]}; i++)); do
            newline 1 && indent ${__bash_doc_arg_indent__}
            format_argument "${len_args}" "${args[$i]}"
            # Argument type
            format_arg_type "${len_types}" "${argtype[$i]}"
            # Newline & indent
            newline 1 && indent +
            # Argument description
            format_arg_desc "${argdesc[$i]}"
            # Newline & indent
            newline 1 && indent
            # Argument default
            printf -- "Default: "
            format_arg_default "${argdefault[$i]}"
        done
    fi
    newline 2 && indent 0
    # Function usage
    indent +
    fmt_help --type="header" "Usage:"
    indent +
    __bash_doc_usage_indent__=${__bash_doc_indent__}

    if [ "${#args[@]}" -gt "0" ]; then
        # Newline & indent
        newline 1 && indent ${__bash_doc_usage_indent__}
        format_func_name "${func_name}"
        for ((i = 0; i < ${#args[@]}; i++)); do
            if [[ "${TERM}" == "rmd" ]]; then

                printf " \\\\\\"
            else
                printf " \\"
            fi
            # Newline & indent
            newline 1 && indent $((__bash_doc_usage_indent__ + 1))
            # Argument
            format_argument "${len_args}" "${args[$i]}"
            # Value
            format_arg_usage "${argdefault[$i]}"
        done
    fi
    newline 1
}

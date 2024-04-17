function need_help {
    if [[ $* =~ (^|[^[:alnum:]_])(-[-]*h(elp)*)([^[:alnum:]_]|$) ]]; then
        if [ ! -t 1 ]; then
            local __fmt_output_redirected__="true"
        fi
        show_help
        return 0
    fi
    return 1
}

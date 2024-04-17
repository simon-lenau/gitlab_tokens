# ================================= > err < ================================== #

function err {
    fmt=""
    reset_fmt=""
    if [[ "${__bash_doc_output_redirected__}" == "false" ]] &&
        [[ "${__bash_doc_has_tput__}" == "true" ]]; then
        fmt="$(tput setaf 1 && tput bold)"
        reset_fmt="$(tput sgr0)"
    fi

    printf "%b" \
        "$(printf "${fmt}[$(date +'%Y/%m/%d -- %H:%M:%S')] %s" \
            "Error in \`$(caller | awk '{print $2":"$1}')\`")" \
        "$(printf "\n${fmt}[$(date +'%Y/%m/%d -- %H:%M:%S')]\t%b" "$@")" \
        "${reset_fmt}\n" \
        >&2
    echo ""
}

# ────────────────────────────────── <end> ─────────────────────────────────── #

# ================================= > max < ================================== #

function max {
    max=0
    for x in ${@}; do
        if [[ $x -gt $max ]]; then
            max=$x
        fi
    done
    echo $max
}

# ────────────────────────────────── <end> ─────────────────────────────────── #

# ================================= > rep < ================================== #

function rep {
    for ((i = 1; i <= $2; i++)); do
        printf -- "${1}"
    done
    echo ''
}

# ────────────────────────────────── <end> ─────────────────────────────────── #

function indent {
    if [[ "$#" -gt "0" ]]; then
        re_num='^[0-9]+$'
        if [[ $1 =~ $re_num ]]; then
            __bash_doc_indent__=$1
        else
            re_plus='^[+]+$'
            re_minus='^[-]+$'

            if [[ $1 =~ $re_plus ]]; then
                __bash_doc_indent__=$((__bash_doc_indent__ + 1))
            elif [[ $1 =~ $re_minus ]]; then
                __bash_doc_indent__=$((__bash_doc_indent__ - 1))
            else
                __bash_doc_indent__=$((__bash_doc_indent__$1))
            fi
        fi
    fi
    if [[ ! "${TERM}" == "rmd" ]]; then
        printf "%s" "$(rep " " $((__bash_doc_indent__ * 3)))"
    else
        :
    fi
}

function newline {
    if [[ ! "${TERM}" == "rmd" ]]; then
        printf "%b" "$(rep "\\\n" $1)"
    else
        printf "%s" "$(rep " <br>" $1)"
    fi
}

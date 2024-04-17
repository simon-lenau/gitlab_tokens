function init_arg {
    args+=("$2")
    argtype+=("$1")
    argdesc+=("$3")
    argdefault+=("$4")
}

function init_desc {
    funcdesc=(${funcdesc[@]} "$@")
}

function init_doc {
    args=()
    argtype=()
    argdesc=()
    argdefault=()
    funcdesc=()
}


function homebrew() {
    local prefix="${@}"
    local completion_files=(${prefix}/etc/bash_completion.d/*)

    # Source completion files added from brew installs.
    for f in "${completion_files[@]}"; do
        . "${f}"
    done
}


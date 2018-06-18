
function homebrew() {
    local prefix="${@}"
    local completion_files=(${prefix}/etc/bash_completion.d/*)

    # Source completion files added from brew installs.
    for f in "${completion_files[@]}"; do
        . "${f}"
    done
}

# # enable programmable completion features (you don't need to enable
# # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# # sources /etc/bash.bashrc).


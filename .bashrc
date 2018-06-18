# PATH and common settings go here, .bashrc is loaded when new windows are
# opened
#
# .bash_profile is executed for login shells, while .bashrc is executed for
# interactive non-login shells.
# http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html

# For Lion, Rubies should be built using gcc rather than llvm-gcc. Since
# /usr/bin/gcc is now linked to /usr/bin/llvm-gcc-4.2, add the following to
# your shell's start-up file: export CC=gcc-4.2
# (The situation with LLVM and Ruby may improve. This is as of 07-23-2011.)
# export CC=gcc-4.2

export DOTFILES="${HOME}/.dotfiles"
export PATH="${PATH}:/usr/local/bin"
export CODE="${HOME}/code"
export OS=${OSTYPE//[0-9.-]*/}

if [[ $OS == "darwin" ]]; then
  export BREW_PREFIX="${HOME}/.homebrew"

  if [[ -d "${BREW_PREFIX}" ]]; then
    # Brew prefix first for easier overrides of OS X defaults.
    export PATH="${BREW_PREFIX}/bin:${PATH}"
    source "${DOTFILES}/homebrew.sh"
    homebrew $(brew --prefix)
  else
    echo "=> Homebrew is not installed, install instructions at http://brew.sh"
  fi
else
  if ! shopt -oq posix; then
    completion_files=("/usr/share/bash-completion/bash_completion", "/etc/bash_completion")

    # Source completion files added from brew installs.
    for f in "${completion_files[@]}"; do
      if [ -f "${f}" ]; then
        source "${f}"
      fi
    done
  fi
fi

# Get the name of the branch we are on
git_prompt_info() {
  branch_prompt=$(__git_ps1 "%s")

  if [ -n "$branch_prompt" ]; then
    status_icon=$(git_status)
    printf "on \e[1;35m$branch_prompt\e[0m $status_icon"
  fi
}

# Show character if changes are pending
git_status() {
  if current_git_status=$(git status | grep 'added to commit' 2> /dev/null); then
    echo '☠'
  fi
}

export COLOR_NONE='\[\e[0m\]' # No Color
export COLOR_LIGHT_PURPLE='\[\e[1;35m\]'
export COLOR_ELECTRIC_YELLOW='\[\e[0;93m\]'

PS1=$COLOR_LIGHT_PURPLE'\u'$COLOR_NONE' at '$COLOR_ELECTRIC_YELLOW'\h'$COLOR_NONE' in \w $(git_prompt_info)\n'$COLOR_ELECTRIC_YELLOW'→ '$COLOR_NONE

alias grep='grep --color=auto'
alias ls='ls -G -l'
alias rm='rm -i'

export NVM_DIR="${HOME}/.nvm"
if [[ -d "${NVM_DIR}" ]]; then
  [[ -f "${NVM_DIR}/nvm.sh" ]] && . "${NVM_DIR}/nvm.sh"
  [[ -f "${NVM_DIR}/bash_completion" ]] && . "${NVM_DIR}/bash_completion"
fi

if [ -f $(which atom) ]; then
  export EDITOR="$(which atom)"
fi

# SEE: https://www.rustup.rs
export PATH="$HOME/.cargo/bin:$PATH"
export CARGO_HOME="$HOME/.cargo"

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# Experiment with HISTORY.
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export HISTSIZE=100000
export HISTFILESIZE=1000000
# Enable sharing of history between parallel terminal sessions.
export HIST_SYNC_COMMAND="history -a; history -c; history -r;"

# Append to the existing PROMPT_COMMAND so that terminal and tab titles retain
# the default behavior.
export PROMPT_COMMAND="${HIST_SYNC_COMMAND} ${PROMPT_COMMAND:+$PROMPT_COMMAND}"


export FUCHSIA_DIR="${CODE}/fuchsia"
if [[ -d $FUCHSIA_DIR ]]; then
  export PATH="${FUCHSIA_DIR}/.jiri_root/bin:$PATH"
  export PATH="${FUCHSIA_DIR}/out/build-zircon/tools:$PATH"
fi

if which to-directory > /dev/null; then eval "$(to-directory --init)"; fi

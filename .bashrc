# PATH and common settings go here, .bashrc is loaded when new windows are opened
#
# .bash_profile is executed for login shells, while .bashrc is executed for
# interactive non-login shells.
# http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html

# For Lion, Rubies should be built using gcc rather than llvm-gcc. Since
# /usr/bin/gcc is now linked to /usr/bin/llvm-gcc-4.2, add the following to
# your shell's start-up file: export CC=gcc-4.2
# (The situation with LLVM and Ruby may improve. This is as of 07-23-2011.)
# export CC=gcc-4.2

export COLOR_NONE='\[\e[0m\]' # No Color
export COLOR_LIGHT_PURPLE='\[\e[1;35m\]'
export COLOR_ELECTRIC_YELLOW='\[\e[0;93m\]'

# Adds ~/.homebrew to path
export PATH=$HOME/.homebrew/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=./node_modules/.bin:$PATH

if [ -f $(brew --prefix)/etc/bash_completion.d/git-completion.bash ]; then
  source $(brew --prefix)/etc/bash_completion.d/git-completion.bash
fi

if [ -f /usr/local/etc/bash_completion.d/npm ]; then
  source /usr/local/etc/bash_completion.d/npm
fi

if [ -f $(brew --prefix)/etc/bash_completion.d/git-prompt.sh ]; then
  source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
fi

if [ -f $(brew --prefix)/opt/autoenv/activate.sh ]; then
  source $(brew --prefix)/opt/autoenv/activate.sh
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

PS1=$COLOR_LIGHT_PURPLE'\u'$COLOR_NONE' at '$COLOR_ELECTRIC_YELLOW'\h'$COLOR_NONE' in \w $(git_prompt_info)\n'$COLOR_ELECTRIC_YELLOW'→ '$COLOR_NONE

alias grep='grep --color=auto'
alias ls='ls -G -l'
alias rm='rm -i'
alias sketch='open -a /Applications/Sketch.app/'
alias pixelmator='open -a /Applications/Pixelmator.app'

source ~/.to/to.sh
source ~/.nvm/nvm.sh

# Rust tools
export PATH=$PATH:~/.multirust/toolchains/stable/cargo/bin

# HISTORY
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export HISTSIZE=100000
export HISTFILESIZE=1000000

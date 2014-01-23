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

source '/usr/local/etc/bash_completion.d/git-prompt.sh'
source '/usr/local/etc/bash_completion.d/git-completion.bash'
source '/usr/local/etc/bash_completion.d/npm'

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


# PS1='\u@\h: \w $(git_prompt_info " (%s)")\n'$COLOR_ELECTRIC_YELLOW'⚡ '$COLOR_LIGHT_PURPLE'→ '$COLOR_NONE
PS1=$COLOR_LIGHT_PURPLE'\u'$COLOR_NONE' at '$COLOR_ELECTRIC_YELLOW'\h'$COLOR_NONE' in \w $(git_prompt_info)\n'$COLOR_ELECTRIC_YELLOW'⚡ '$COLOR_NONE

export PATH=/usr/local/bin:/usr/local/share/python:/usr/local/opt/ruby/bin:$PATH

source /usr/local/Cellar/autoenv/0.1.0/activate.sh
autoenv_init # Make sure .env gets picked up when new terminal tabs are opened

alias grep='grep --color=auto'
alias ls='ls -G'
alias rm='rm -i'
alias sketch='open -a /Applications/Sketch.app/'
alias ia-writer='open -a /Applications/iA\ Writer.app'
alias pixelmator='open -a /Applications/Pixelmator.app'
alias marked='open -a /Applications/Marked.app'

source ~/.to/to.sh
source ~/.nvm/nvm.sh
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

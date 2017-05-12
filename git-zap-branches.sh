
zap() {
  echo "$@"
  while true; do
    read -p "Are you sure you want to zap these branches? " yn
    case $yn in
        [Yy]* ) echo "$@" | xargs git branch -D; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
  done
}

run() {
  # Git branches that are not "master" or the current branch.
  local BRANCHES="$(git branch | awk '!/master/ && !/^\*/')"

  # There are no branches to safely remove.
  if [[ -z "${BRANCHES// }" ]]; then
    return 0
  fi

  # If the command for getting the branches errors display a helpful message.
  if [[ "$?" -eq 0 ]]; then
    zap "${BRANCHES}"
    return 0
  else
    echo "ERROR => Failed to list branches:"
    echo "${BRANCHES}"
    return 1
  fi
}

run "$@"

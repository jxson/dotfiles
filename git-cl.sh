
run() {
  local branch=$(git rev-parse --abbrev-ref HEAD)
  local handle=$(whoami)
  local topic="topic=${handle}-${branch}"
  git push origin HEAD:refs/for/master%${topic}
}

run "$@"

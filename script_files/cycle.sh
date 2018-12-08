# The cycle function

function cycle() {

  echo "Starting the cycle.."

  bash "${PATH_REPOTOOLS}/repotools" -s

  bash "${PATH_REPOTOOLS}/repotools" -d

  bash "${PATH_REPOTOOLS}/repotools" -u

  bash "${PATH_REPOTOOLS}/repotools" -s

}
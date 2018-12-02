# Functions for updating repositories

function update_repository() {
  local REPOSITORY_NAME="$1"; shift

  if [[ ! -z "${REPOSITORY_NAME}" ]]; then
    # update a single repository
    source_pkg_config "${REPOSITORY_NAME}"

    aursync --repo "$NAME" --root "$PATH_REPOSITORIES/$REPOSITORY_NAME/pkg" -u
  else
    # update all repositories
    echo "$(ls ${PATH_REPOSITORIES})" > "repositories.tmp" 

    # todo: use mktemp
    while read -r line; do
      bash "${PATH_REPOTOOLS}/repotools" -U "${line}"
    done < "repositories.tmp"

  fi
}
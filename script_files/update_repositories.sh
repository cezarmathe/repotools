# Functions for updating repositories

function update_repository() {
  local repository_name="$1"; shift

  if [[ ! -z "${repository_name}" ]]; then
    # update a single repository
    source_pkg_config "${repository_name}"

    aursync --repo "$NAME" --root "$PATH_REPOSITORIES/$repository_name/pkg" -u
  else
    # update all repositories
    echo "$(ls ${PATH_REPOSITORIES})" > "repositories.tmp" 

    # todo: use mktemp
    while read -r line; do
      bash "${PATH_REPOTOOLS}/repotools" -U "${line}"
    done < "repositories.tmp"

  fi
}
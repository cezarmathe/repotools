# Functions for updating repositories

function update_repository() {
  local REPO="$1"; shift

  if [[ ! -z "${REPO}" ]]; then
    # update a single repository
    source_pkg_config "${REPO}"

    aursync --repo "$NAME" --root "$GLOBAL_REPO_DIR/$REPO/pkg" -u
  else
    # update all repositories
    echo "$(ls ${GLOBAL_REPO_DIR})" > "repositories.tmp" 

    while read -r line; do
      bash "${REPOTOOLS_PATH}/repotools" -U "${line}"
    done < "repositories.tmp"

  fi
}
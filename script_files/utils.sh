# Utilities

function source_pkg_config() {

  local REPOSITORY_NAME="$1"; shift

  if [[ ! -f "${GLOBAL_REPO_DIR}/${REPOSITORY_NAME}/.config" ]]; then
    echo "The repository ${REPOSITORY_NAME} has no config file."
    exit
  fi

  source "${GLOBAL_REPO_DIR}/${REPOSITORY_NAME}/.config"

  # echo "${LOCAL_DB_FILE}"
}

function remove_tmp_files() {
  rm "${REPOTOOLS_PATH}"/*.tmp
}
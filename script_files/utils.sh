# Utilities

function source_pkg_config() {

  local REPO="$1"; shift

  if [[ ! -f "${GLOBAL_REPO_DIR}/${REPO}/.config" ]]; then
    echo "The repository ${REPO} has no config file."
    exit
  fi

  source "${GLOBAL_REPO_DIR}/${REPO}/.config"

  echo "${LOCAL_DB_FILE}"
}

function remove_tmp_files() {
  rm "${REPOTOOLS_PATH}"/*.tmp
}
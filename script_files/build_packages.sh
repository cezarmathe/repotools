# Functions for building packages

function build_package() {
  local REPO="$1"; shift
  local PACKAGE_NAME="$1"; shift

  if [[ ! -d "${GLOBAL_REPO_DIR}/${REPO}/src" ]]; then
    echo "The repository ${REPO} does not have packages that need to be built."
    return
  fi

  source_pkg_config "${REPO}"

  if [[ ! -z "${PACKAGE_NAME}" ]]; then
    # build a single package
    if [[ ! -d "${GLOBAL_REPO_DIR}/${REPO}/src/${PACKAGE_NAME}" ]]; then
      echo "The repository ${REPO} does not have a buildable package named ${PACKAGE_NAME}."
      return
    else
      local previous_wd="$(pwd)"

      cd "${GLOBAL_REPO_DIR}/${REPO}/src/${PACKAGE_NAME}"
      makechrootpkg -cur "${GLOBAL_BUILD_DIR}"

      repo-add "${GLOBAL_REPO_DIR}/${REPO}/${LOCAL_DB_FILE}" *.pkg.tar.xz

      cd "${previous_wd}"
    fi
  else

    echo "$(ls ${GLOBAL_REPO_DIR}/${REPO}/src)" > "packages.tmp"

    while read -r line; do
      bash "${REPOTOOLS_PATH}/repotools" -B "${line}" "${REPO}"
    done < "packages.tmp"
  fi
}

function build_all_packages() {
  echo "$(ls ${GLOBAL_REPO_DIR})" > "repositories.tmp" 

  while read -r line; do
    bash "${REPOTOOLS_PATH}/repotools" -b "${line}"
  done < "repositories.tmp"
}
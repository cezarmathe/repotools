# Functions for building packages

# Build a single package from a repository
# or all packages within repository
# Calling this function with no parameters
# build all packages within repository
function build_package() {
  local REPOSITORY_NAME="$1"; shift
  local PACKAGE_NAME="$1"; shift

  if [[ ! -d "${PATH_REPOSITORIES}/${REPOSITORY_NAME}/src" ]]; then
    echo "The repository ${REPOSITORY_NAME} does not have packages that need to be built."
    return
  fi

  source_pkg_config "${REPOSITORY_NAME}"

  if [[ ! -z "${PACKAGE_NAME}" ]]; then
    # build a single package within a repository
    if [[ ! -d "${PATH_REPOSITORIES}/${REPOSITORY_NAME}/src/${PACKAGE_NAME}" ]]; then
      echo "The repository ${REPOSITORY_NAME} does not have a buildable package named ${PACKAGE_NAME}."
      return
    else
      local previous_wd="$(pwd)"

      cd "${PATH_REPOSITORIES}/${REPOSITORY_NAME}/src/${PACKAGE_NAME}"
      makechrootpkg -cur "${GLOBAL_BUILD_DIR}"

      repo-add "${PATH_REPOSITORIES}/${REPOSITORY_NAME}/${LOCAL_DB_FILE}" *.pkg.tar.xz

      cp *.pkg.tar.xz "${PATH_REPOSITORIES}/${REPOSITORY_NAME}/${LOCAL_DB_FILE}/"

      cd "${previous_wd}"
    fi
  else
    # build all packages within a repository
    # todo: mktmp instead of manual temp file
    echo "$(ls ${PATH_REPOSITORIES}/${REPOSITORY_NAME}/src)" > "packages.tmp"

    while read -r line; do
      bash "${REPOTOOLS_PATH}/repotools" -B "${line}" "${REPOSITORY_NAME}"
    done < "packages.tmp"
  fi
}

# Build all packages from all repositories
function build_all_packages() {
  echo "$(ls ${PATH_REPOSITORIES})" > "repositories.tmp" 

  while read -r line; do
    bash "${REPOTOOLS_PATH}/repotools" -b "${line}"
  done < "repositories.tmp"
}
# Functions for adding and removing packages from repositories

# Add a package to the specified repository
function add_package() {
  local REPOSITORY_NAME="$1"; shift
  local PACKAGE_NAME="$1"; shift

  aursync --repo "${REPOSITORY_NAME}" --root "${PATH_REPOSITORIES}/${REPOSITORY_NAME}/pkg" "${PACKAGE_NAME}"
}

# Remove a package from the specified repository
function remove_package() {
  local REPOSITORY_NAME="$1"; shift
  local PACKAGE_NAME="$1"; shift

  source_pkg_config "${REPOSITORY_NAME}"

  cd "${PATH_REPOSITORIES}/${REPOSITORY_NAME}"

  repo-remove "${PATH_REPOSITORIES}/${REPOSITORY_NAME}/${LOCAL_DB_FILE}" "${PACKAGE_NAME}"

  rm "${PATH_REPOSITORIES}/${REPOSITORY_NAME}/pkg/${PACKAGE_NAME}-*.pkg.tar.xz"
}
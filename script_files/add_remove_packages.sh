# Functions for adding and removing packages from repositories

function add_package() {
  local REPO="$1"; shift
  local PACKAGE_NAME="$1"; shift

  aursync --repo "${REPO}" --root "${GLOBAL_REPO_DIR}/${REPO}/pkg" "$PACKAGE_NAME"
}

function remove_package() {
  local REPO="$1"; shift
  local PACKAGE_NAME="$1"; shift

  source_pkg_config "${REPO}"

  cd "${GLOBAL_REPO_DIR}/${REPO}"

  repo-remove "${GLOBAL_REPO_DIR}/${REPO}/${LOCAL_DB_FILE}" "$PACKAGE_NAME"

  rm "${GLOBAL_REPO_DIR}/${REPO}/pkg/$PKG_NAME-*.pkg.tar.xz"
}
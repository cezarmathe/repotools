# Functions for interacting with the build environment

function initialize_build_environment() {
  local DIR="$1"; shift

  if [[ -z "${DIR}" ]]; then
    mkdir -p "${GLOBAL_BUILD_DIR}"
    mkarchroot -C /etc/pacman.conf "${GLOBAL_BUILD_DIR}/root" base-devel
  else
    if [[ "${DIR:0:1}" = "/" ]]; then
      mkdir -p "${DIR}"
      mkarchroot -C /etc/pacman.conf "${DIR}/root" base-devel
    else
      mkdir -p "${REPOTOOLS_PATH}/${DIR}"
      mkarchroot -C /etc/pacman.conf "${REPOTOOLS_PATH}/${DIR}}/root" base-devel
    fi
  fi
}
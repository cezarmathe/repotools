# Functions for interacting with the build environment

function initialize_build_environment() {
  local DIRECTORY="$1"; shift

  if [[ -z "${DIRECTORY}" ]]; then
    mkdir -p "${PATH_BUILD}"
    mkarchroot -C /etc/pacman.conf "${PATH_BUILD}/root" base-devel
  else
    if [[ "${DIRECTORY:0:1}" = "/" ]]; then
      mkdir -p "${DIRECTORY}"
      mkarchroot -C /etc/pacman.conf "${DIRECTORY}/root" base-devel
    else
      mkdir -p "${PATH_REPOTOOLS}/${DIRECTORY}"
      mkarchroot -C /etc/pacman.conf "${PATH_REPOTOOLS}/${DIRECTORY}}/root" base-devel
    fi
  fi
}
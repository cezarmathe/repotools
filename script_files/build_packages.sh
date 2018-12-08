# Functions for building packages

# Build a single package from a repository
# or all packages within repository
# Calling this function with no parameters
# build all packages within repository
function build_package() {
  local repository_name="$1"; shift
  local package_name="$1"; shift

  if [[ ! -d "${PATH_REPOSITORIES}/${repository_name}/src" ]]; then
    echo "The repository ${repository_name} does not have packages that need to be built."
    return
  fi

  source_pkg_config "${repository_name}"

  if [[ ! -z "${package_name}" ]]; then
    # build a single package within a repository
    if [[ ! -d "${PATH_REPOSITORIES}/${repository_name}/src/${package_name}" ]]; then
      echo "The repository ${repository_name} does not have a buildable package named ${package_name}."
      return
    else
      local previous_wd="$(pwd)"

      cd "${PATH_REPOSITORIES}/${repository_name}/src/${package_name}"
      makechrootpkg -cur "${GLOBAL_BUILD_DIR}"

      repo-add "${PATH_REPOSITORIES}/${repository_name}/${LOCAL_DB_FILE}" *.pkg.tar.xz

      cp *.pkg.tar.xz "${PATH_REPOSITORIES}/${repository_name}/${LOCAL_DB_FILE}/"

      cd "${previous_wd}"
    fi
  else
    # build all packages within a repository
    echo "$(ls ${PATH_REPOSITORIES}/${repository_name}/src)" > "packages.tmp"

    for packagename in "${PATH_REPOSITORIES}/${repository_name}/src/*"; do
      bash "${PATH_REPOTOOLS}/repotools" -B "${packagename}"
    done 
  fi
}

# Build all packages from all repositories
function build_all_packages() {
  echo "$(ls ${PATH_REPOSITORIES})" > "repositories.tmp" 

  for reponame in "${PATH_REPOSITORIES}/*"; do
      bash "${PATH_REPOTOOLS}/repotools" -b "${reponame}"
  done 
}
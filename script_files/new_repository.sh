# Functions for creating a new repository

function new_repository() {
  local repository_name="$1"; shift

  if [[ -d "${PATH_REPOSITORIES}/${repository_name}" ]]; then
    echo "The repository already exists."
  else
    # create the repository directory
    mkdir "${PATH_REPOSITORIES}/${repository_name}"

    # create the pkg dir and the database
    mkdir "${PATH_REPOSITORIES}/${repository_name}/pkg"
    repo-add "${PATH_REPOSITORIES}/${repository_name}/pkg/${repository_name}.db.tar.xz"

    # create a folder for meta packages if required
    if [[ -z "${arg_new_repo}" ]]; then
      mkdir "${PATH_REPOSITORIES}/${repository_name}/src"
    fi

    # create the config file
    touch "${PATH_REPOSITORIES}/${repository_name}/.config"
    
    echo "# Configuration file for the repository\n"
    echo "LOCAL_REPOSITORY_NAME=${repository_name}"

    cat > "${PATH_REPOSITORIES}/${repository_name}/.config" <<EOF

      LOCAL_REMOTE_PACKAGE_DIR="insert url here"

      LOCAL_DB_FILE="pkg/$NAME.db.tar.xz"

      LOCAL_REMOTE_REPO_ADDRESS="insert url here"
    EOF 
    
    vim "${PATH_REPOSITORIES}/${repository_name}/.config"

  fi
}
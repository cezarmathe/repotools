# Functions for creating a new repository

function new_repository() {
  local REPOSITORY_NAME="$1"; shift

  if [[ -d "${PATH_REPOSITORIES}/${REPOSITORY_NAME}" ]]; then
    echo "The repository already exists."
  else
    git clone --depth 1 https://github.com/cezarmathe/example_repository.git "${PATH_REPOSITORIES}/${REPOSITORY_NAME}"

    if [[ ! -z "${arg_open_config_in_editor}" ]]; then
      vim "${PATH_REPOSITORIES}/${REPOSITORY_NAME}/.config"
    fi

    repo-add "${PATH_REPOSITORIES}/${REPOSITORY_NAME}/pkg/${REPOSITORY_NAME}.db.tar.xz"

    # TODO: change config file to match the repo name and other config variables
  fi
}
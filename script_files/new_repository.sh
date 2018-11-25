# Functions for creating a new repository

function new_repository() {
  local NAME="$1"; shift

  if [[ -d "${GLOBAL_REPO_DIR}/${NAME}" ]]; then
    echo "The repository already exists."
  else
    git clone --depth 1 https://github.com/cezarmathe/example_repository.git "${GLOBAL_REPO_DIR}/${NAME}"

    if [[ ! -z "${arg_open_config_in_editor}" ]]; then
      vim "${GLOBAL_REPO_DIR}/${NAME}/.config"
    fi

    repo-add "${GLOBAL_REPO_DIR}/${NAME}/pkg/${NAME}.db.tar.xz"

    # TODO: change config file to match the repo name and other config variables
  fi
}
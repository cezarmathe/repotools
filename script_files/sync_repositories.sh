# Functions for syncing repositories with the remote

function sync_with_remote() {
  local REPOSITORY_NAME="$1"; shift

  if [[ ! -z "${REPOSITORY_NAME}" ]]; then
    # sync a single repository
    if [[ ! -d "${PATH_REPOSITORIES}/${REPOSITORY_NAME}" ]]; then
      echo "Repository ${REPOSITORY_NAME} does not exist."
    else

      source_pkg_config "${REPOSITORY_NAME}"

      if [[ ! -z "${LOCAL_REMOTE_GIT_ADDRESS}" ]]; then
        echo "The repository ${REPOSITORY_NAME} does not have a remote git address configured."
        return
      fi

      git --work-tree="${PATH_REPOSITORIES}/${REPOSITORY_NAME}/" --git-dir="${PATH_REPOSITORIES}/${REPOSITORY_NAME}/.git"  remote update

      git --work-tree="${PATH_REPOSITORIES}/${REPOSITORY_NAME}/" --git-dir="${PATH_REPOSITORIES}/${REPOSITORY_NAME}/.git" commit -a -m "$(date)"

      local UPSTREAM=${1:-'@{u}'}
      local LOCAL=$(git --work-tree=${PATH_REPOSITORIES}/${REPOSITORY_NAME}/ --git-dir=${PATH_REPOSITORIES}/${REPOSITORY_NAME}/.git rev-parse @)
      local REMOTE=$(git --work-tree=${PATH_REPOSITORIES}/${REPOSITORY_NAME}/ --git-dir=${PATH_REPOSITORIES}/${REPOSITORY_NAME}/.git rev-parse "$UPSTREAM")
      local BASE=$(git --work-tree=${PATH_REPOSITORIES}/${REPOSITORY_NAME}/ --git-dir=${PATH_REPOSITORIES}/${REPOSITORY_NAME}/.git merge-base @ "$UPSTREAM")

      if [ $LOCAL = $REMOTE ]; then
        echo "The repository ${REPOSITORY_NAME} is up to date."
      elif [ $LOCAL = $BASE ]; then
        echo "${REPOSITORY_NAME} is not up to date with the remote, pulling the changes.."
        git --work-tree="${PATH_REPOSITORIES}/${REPOSITORY_NAME}/" --git-dir="${PATH_REPOSITORIES}/${REPOSITORY_NAME}/.git" pull "${LOCAL_REMOTE_REPO_ADDRESS}" master

      elif [ $REMOTE = $BASE ]; then
        echo "${REPOSITORY_NAME} is ahead of the remote, pushing the changes.."            
        git --work-tree="${PATH_REPOSITORIES}/${REPOSITORY_NAME}/" --git-dir="${PATH_REPOSITORIES}/${REPOSITORY_NAME}/.git" push "${LOCAL_REMOTE_REPO_ADDRESS}" master
      else
        echo "${REPOSITORY_NAME} and the remote are diverged."
      fi
    fi
  else
    echo "Syncing all repositories."
    for reponame in "${PATH_REPOSITORIES}/*"; do
      bash "${REPOTOOLS_PATH}/repotools" -S "${reponame}"
    done 
  fi
}
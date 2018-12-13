#!/bin/bash

file_list=("LICENSE"
          "repotools"
          "repotools.conf"
          "modules/add_remove_packages.sh"
          "modules/build_environment.sh "
          "modules/build_packages.sh"
          "modules/cycle.sh"
          "modules/help_usage.sh "
          "modules/new_meta_package.sh "
          "modules/new_repository.sh"
          "modules/pacman_entries.sh "
          "modules/sync_repositories.sh "
          "modules/update_repositories.sh "
          "modules/utils.sh")

# Source the PKGBUILD for variables
source package/PKGBUILD

# Move the PKGBUILD and .SRCINFO
# cp -f package/PKGBUILD ${HOME}/Packages/repotools/PKGBUILD
# makepkg --printsrcinfo > ${HOME}/Packages/repotools/.SRCINFO

for file in ${file_list[@]}; do
  echo ${file} >> file_list.txt
done

tar -czf "tar/v${pkgver}" -T file_list.txt

rm file_list.txt
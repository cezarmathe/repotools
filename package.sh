#!/bin/bash

cp -f package/PKGBUILD ${HOME}/Packages/repotools/PKGBUILD

cp -f repotools ${HOME}/Packages/repotools/repotools

cp -f repotools.conf ${HOME}/Packages/repotools/repotools.conf

cp -f LICENSE ${HOME}/Packages/repotools/LICENSE

cp -rf modules/*.sh ${HOME}/Packages/repotools/

cd ${HOME}/Packages/repotools

makepkg --printsrcinfo > .SRCINFO

git add -A

git commit -a

git push origin master
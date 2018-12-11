#!/bin/bash

cp repotools package/repotools

cp repotools.conf package/repotools.conf

cp LICENSE package/LICENSE

cp -r modules/*.sh package/

cd package

makepkg -c -i

rm *.sh

rm LICENSE

rm repotools

rm repotools.conf
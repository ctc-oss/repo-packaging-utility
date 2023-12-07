#!/bin/bash

# Deletes the 'user.repo.*' filesystem extended attributes for
# the given file list provided via stdin

readonly repo_attr='user.repo.sha256sum'

while read -r repo_file; do
  echo $repo_file
  setfattr -x "${repo_attr}" "${repo_file}" 
done

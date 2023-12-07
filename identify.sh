#!/bin/bash

# Inspects the given file to 'identify' if the file was never included
# in a previous repository data set.
#
# Files previously included in a repo data set will contain the 'user.repo.sha256sum'
# key/value pair metadata in the filesystem extended attribures.

readonly repo_file=$1
readonly repo_attr="user.repo.sha256sum"
  
getfattr -n "${repo_attr}" "${repo_file}" > /dev/null 2>&1

# ifile is missing 'user.repo.sha256sum', echo the relative path
# if file does include 'user.repo.sha256sum', then create and compare hash
#   if hashes do not match, include file relative path

if [ $? -ne 0 ]; then
  echo "${repo_file}"
else
  readonly current_hash=$(sha256sum "${repo_file}" | cut -d' ' -f 1)
  readonly previous_hash=$(getfattr -n "${repo_attr}" --only-values "${repo_file}")
  if [[ "${current_hash}" != "${previous_hash}" ]]; then
    echo "${repo_file}"
  fi
fi

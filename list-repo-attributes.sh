#!/bin/bash 

script_dir=$(dirname "$(readlink -f "$0")")

readonly repo_dir="${1}"

if [ -z "${repo_dir}" ]; then
  echo "Error: missing repository directory"
  echo "usage: $(basename "$0") <repository-directory>"
  exit 1
fi

getfattr -dR "${repo_dir}"

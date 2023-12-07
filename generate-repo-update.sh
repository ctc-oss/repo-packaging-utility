#!/bin/bash

readonly repo_attr='user.repo.sha256sum'
readonly tar_file="${1}"

if [ -z "${tar_file}" ]; then
  echo "Error: missing tar file argument"
  echo "usage: $(basename "$0") <tar-file>"
  echo "example: find-repo-updates.sh repo/ | generate-repo-updates.sh repo-updates-\$(date +\"%Y%m%d\").tar"
  exit 1
fi

while read -r repo_file; do
  (\
    setfattr -n "${repo_attr}" -v $(sha256sum "${repo_file}" | cut -d' ' -f 1) "${repo_file}"; \
    setfattr -n 'user.repo.update-file' -v "${tar_file}" "${repo_file}"\
  )

done

cript_dir=$(dirname "$(readlink -f "$0")")

readonly repo_dir="${1}"
readonly tar_file="${2}"

if [ -z "${tar_file}" ]; then
  echo "Error: missing tar file argument"
  echo "usage: $(basename "$0") <repository_directory> <tar-file>"
  echo "example: find-by-repo.sh repo/ updates.tar"
  exit 1
fi

if [ -z "${repo_dir}" ]; then
  echo "Error: missing repository directory"
  echo "usage: $(basename "$0") <repository_directory> <tar-file>"
  echo "example: find-by-repo.sh repo/ updates.tar"
  exit 1
fi

find ${repo_dir} -type f -exec sh -c '
    [ "$(getfattr --only-values -n user.repo.update-file "$1" 2>/dev/null)" = "${tar_file}" ]
' find-sh {} \; -print

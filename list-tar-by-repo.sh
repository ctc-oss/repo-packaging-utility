#!/bin/bash

readonly repo_dir=$1
readonly repo_attr="user.repo.update-file"

getfattr -Rn ${repo_attr} ${repo_dir} 2> /dev/null | grep user.repo.update | sort | uniq -c

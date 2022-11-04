#!/bin/env bash

set -o pipefail

board=${1:-x86}
update=${2:-yes}
parallel=${3:-1}

export TASKNAME="${board}"
export TASKNAME_SUFFIX="_${board}"

if [[ "${update}" != "no" ]]; then
  local_branch=$(git branch --show-current)
  branch=$(git rev-parse --abbrev-ref remotes/origin/HEAD | sed -e "s/^origin\///")
  if [[ "${local_branch}" != "${branch}" ]]; then
    until git fetch origin "${branch}":"${branch}" -u --tags; do
      sleep 1
    done

    until git rebase "${branch}"; do
      sleep 1
    done
  else
    until git pull --rebase; do
      sleep 1
    done
  fi

  git submodule foreach git pull --rebase

  while IFS= read -r -d '' d; do
    pushd "$d" || exit
    local_branch=$(git branch --show-current)
    branch=$(git rev-parse --abbrev-ref remotes/origin/HEAD | sed -e "s/^origin\///")
    if [[ "${local_branch}" != "${branch}" ]]; then
      until git fetch origin "${branch}":"${branch}" -u --tags; do
        sleep 1
      done

      until git rebase "${branch}"; do
        sleep 1
      done
    else
      until git pull --rebase; do
        sleep 1
      done
    fi
    popd || exit
  done < <(find -L ./feeds -maxdepth 1 -mindepth 1 -type d ! \( -name '*tmp' -o -iname 'base' \) -print0)

  until ./scripts/feeds update -i; do
    sleep 1
  done

  until ./scripts/feeds install -a; do
    sleep 1
  done
fi

yes "" | make oldconfig

idx=0
while [ -f "compile.log.${board}.${idx}" ]; do ((idx++)); done

(yes "" || :) | make V=sc -j"${parallel}" 2>&1 | tee -a "compile.log.${board}.${idx}"

if [[ $? -eq 0 ]] && [[ $1 == "x86" ]]; then
  rsync --progress -b --suffix ".$(date +'%Y%m%d%k%M')" ./bin/targets/x86/64/*wrt-x86-64-generic-rootfs.tar.gz _pve:/var/lib/vz/template/cache
fi

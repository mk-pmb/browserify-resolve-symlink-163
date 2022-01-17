#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function demo_main () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  local SELFPATH="$(readlink -m -- "$BASH_SOURCE"/..)"

  export CI=true
  cd / || return $?
  vdo whoami || return $?
  vdo npm --versions || return $?
  vdo npm root --global || return $?

  export HOME="$SELFPATH/prepare"
  cd -- "$HOME" || return $?
  vdo npm install . || return $?
  maybe_fix_node_modules_symlink_broken_by_npm || return $?

  export HOME="$SELFPATH"/home/demo
  cd -- "$HOME/my-cool-app" || return $?
  vdo node app.js &> >(tee -- "$SELFPATH"/example_output.txt) || return $?
}


function vdo () {
  local SHORT_PWD="$PWD"
  SHORT_PWD="${SHORT_PWD/#${SELFPATH%/*}\//\/…\/}"
  local DESCR="$*"
  DESCR="${DESCR#eval }"
  [ "${#DESCR}" -lt 50 ] || DESCR="${DESCR:0:49}…"
  echo "----- 8< --== $DESCR @ $SHORT_PWD ==-- 8< ----- 8< ----- 8< ----- 8< -----"
  "$@"
  local RV=$?
  echo "----- >8 --== $DESCR => rv=$RV  ==-- >8 ----- >8 ----- >8 ----- >8 -----"
  echo
  return "$RV"
}


function maybe_fix_node_modules_symlink_broken_by_npm () {
  # npm v8 insists on replacing our perfectly fine `node_modules` symlink
  # with a regular subdirectory. (ref: #node.js IRC logs 2022-01-17T01:52:40Z)
  [ -L node_modules ] && return 0
  mv --no-target-directory -- node_modules nm || return $?
  git checkout -- node_modules || return $?
  rm --recursive -- \
    nm/.bin \
    nm/.package-lock.json \
    2>/dev/null || true
  mv --target-directory=node_modules/ -- nm/[a-z]*/ || return $?
  rmdir -- nm && return 0
  echo "W: rmdir failed, rv=$?" >&2
  vdo ls -lFa -- nm >&2
  return 8
}


demo_main "$@"; exit $?

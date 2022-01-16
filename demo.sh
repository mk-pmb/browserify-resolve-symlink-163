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

  export HOME="$SELFPATH"/home/demo
  cd -- "$HOME/my-cool-app" || return $?
  vdo node app.js &> >(tee -- "$SELFPATH"/example_output.txt) || return $?
}


function vdo () {
  local SHORT_PWD="$PWD"
  SHORT_PWD="${SHORT_PWD/#${SELFPATH%/*}\//\/…\/}"
  local DESCR="$*"
  [ "${#DESCR}" -lt 50 ] || DESCR="${DESCR:0:49}…"
  echo "----- 8< --== $DESCR @ $SHORT_PWD ==-- 8< ----- 8< ----- 8< ----- 8< -----"
  "$@"
  local RV=$?
  echo "----- >8 --== $DESCR => rv=$RV  ==-- >8 ----- >8 ----- >8 ----- >8 -----"
  echo
  return "$RV"
}


demo_main "$@"; exit $?

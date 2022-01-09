#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function demo_main () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  local SELFPATH="$(readlink -m -- "$BASH_SOURCE"/..)"

  export CI=true
  export HOME="$SELFPATH/prepare"
  cd -- "$HOME" || return $?
  vdo npm --versions
  vdo npm install . || return $?

  export HOME="$SELFPATH"/home/demo
  cd -- "$HOME/my-cool-app" || return $?
  vdo node app.js || return $?
}


function vdo () {
  local SHORT_PWD="$PWD"
  SHORT_PWD="${SHORT_PWD/#${SELFPATH%/*}\//\/…\/}"
  echo "----- 8< --== $* @ $SHORT_PWD ==-- 8< ----- 8< ----- 8< ----- 8< -----"
  "$@"
  local RV=$?
  echo "----- >8 --== $* => rv=$RV  ==-- >8 ----- >8 ----- >8 ----- >8 -----"
  echo
  return "$RV"
}


demo_main "$@"; exit $?

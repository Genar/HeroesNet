#!/bin/bash

set -euo pipefail

function checkTuist() {

  if ! command -v tuist &> /dev/null
    then
      echo "Installing Tuist";
        curl -Ls https://install.tuist.io | bash
  fi
}

function runTuist() {

  tuist install 2.1.1
  tuist generate 
  xed .
}

function run() {

  checkTuist
  runTuist
}

run


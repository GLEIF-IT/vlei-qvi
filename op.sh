#!/bin/bash

##################################################################
##                                                              ##
##      Salt/Passcode creation/retrieval in 1Password           ##
##                                                              ##
##################################################################


function kli() {
  docker run -it --rm -v "${HOME}"/.qar:/usr/local/var/keri -v "${QAR_SCRIPT_DIR}":/scripts -v "${QAR_DATA_DIR}":/data gleif/keri:0.6.7 kli "$@"
}

export -f kli

op vault get QVI >/dev/null 2>&1
ret=$?
if [ $ret -eq 1 ]; then
  echo "Generating QVI Vault"
  op vault create QVI >/dev/null 2>&1
fi

op item get passcode --vault QVI --fields label=value >/dev/null 2>&1
ret=$?
if [ $ret -eq 1 ]; then
  echo "Generating random passcode and storing in 1Password"
  op item create --category password --title "passcode" --vault QVI value="$(kli passcode generate |  tr -d '\r')"  >/dev/null 2>&1
fi

op item get salt --vault QVI --fields label=value >/dev/null 2>&1
ret=$?
if [ $ret -eq 1 ]; then
  echo "Generating random salt and storing in 1Password"
  op item create --category password --title "salt" --vault QVI value="$(kli salt |  tr -d '\r')"  >/dev/null 2>&1
fi

echo "Retrieving passcode from 1Password"
op item get passcode --vault QVI --fields label=value

echo "Retrieving salt from 1Password"
op item get salt --vault QVI --fields label=value

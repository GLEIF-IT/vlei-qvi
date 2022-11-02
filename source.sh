#!/bin/bash

##################################################################
##                                                              ##
##          Initialization script for a QAR                     ##
##                                                              ##
##################################################################

# Change to the name you want to use for your local database environment.
export QAR_NAME="QAR"

# Change to the name you want for the alias for your local QAR AID
export QAR_ALIAS="John Doe"

# Set current working directory for all scripts that must access files
QAR_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export QAR_SCRIPT_DIR="${QAR_DIR}/scripts"
export QAR_DATA_DIR="${QAR_DIR}/data"

function kli() {
  docker run -it --rm -v "${HOME}"/.qar:/usr/local/var/keri -v "${QAR_SCRIPT_DIR}":/scripts -v "${QAR_DATA_DIR}":/data gleif/keri:0.6.7 kli "$@"
}

export -f kli

# Creates the passcode for your local keystore and saves it in your keychain.  Will not overwrite
passcode="$(security find-generic-password -w -a "${LOGNAME}" -s qar-passcode 2> /dev/null)"
if [ -z "${passcode}" ]; then
  echo "Generating random passcode and storing in Keychain"
  security add-generic-password -a "${LOGNAME}" -s qar-passcode -w "$(kli passcode generate |  tr -d '\r')"
fi

# Creates the salt for your local keystore and saves it in your keychain.  Will not overwrite
salt="$(security find-generic-password -w -a "${LOGNAME}" -s qar-salt 2> /dev/null)"
if [ -z "${salt}" ]; then
  echo "Generating random salt and storing in Keychain"
  security add-generic-password -a "${LOGNAME}" -s qar-salt -w "$(kli salt | tr -d '\r')"
fi
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

kli() {
  docker run -it --rm -v "${HOME}"/.qar:/usr/local/var/keri -v "${QAR_SCRIPT_DIR}":/scripts -v "${QAR_DATA_DIR}":/data gleif/keri:0.6.7 kli "$@"
}
export -f kli >/dev/null 2>&1

set_passcode() {
  if [ "$1" = "--insecure" ]; then
    export QVI_PASSCODE=$(kli passcode generate |  tr -d '\r')
  elif [ "$1" = "--op" ]; then
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
  else
    passcode="$(security find-generic-password -w -a "${LOGNAME}" -s qar-passcode 2> /dev/null)"
    if [ -z "${passcode}" ]; then
      echo "Generating random passcode and storing in Keychain"
      security add-generic-password -a "${LOGNAME}" -s qar-passcode -w "$(kli passcode generate |  tr -d '\r')"
    fi
  fi
}
export -f set_passcode >/dev/null 2>&1

get_passcode() {
  if [ "$1" = "--insecure" ]; then
    echo $QVI_PASSCODE
  elif [ "$1" = "--op" ]; then
    echo $(op item get passcode --vault QVI --fields label=value)
  else
    echo $(security find-generic-password -w -a "${LOGNAME}" -s qar-passcode)
  fi
}
export -f get_passcode >/dev/null 2>&1

set_salt() {
    if [ "$1" = "--insecure" ]; then
      export QVI_SALT=$(kli salt |  tr -d '\r')
    elif [ "$1" = "--op" ]; then
      op vault get QVI >/dev/null 2>&1
      ret=$?
      if [ $ret -eq 1 ]; then
        echo "Generating QVI Vault"
        op vault create QVI >/dev/null 2>&1
      fi

      op item get salt --vault QVI --fields label=value >/dev/null 2>&1
      ret=$?
      if [ $ret -eq 1 ]; then
        echo "Generating random salt and storing in 1Password"
        op item create --category password --title "salt" --vault QVI value="$(kli salt |  tr -d '\r')"  >/dev/null 2>&1
      fi
    else
      passcode="$(security find-generic-password -w -a "${LOGNAME}" -s qar-passcode 2> /dev/null)"
      if [ -z "${passcode}" ]; then
        echo "Generating random passcode and storing in Keychain"
        security add-generic-password -a "${LOGNAME}" -s qar-passcode -w "$(kli passcode generate |  tr -d '\r')"
      fi
    fi
}

get_salt() {
  if [ "$1" = "--insecure" ]; then
    echo $QVI_SALT
  elif [ "$1" = "--op" ]; then
    echo $(op item get salt --vault QVI --fields label=value)
  else
    echo $(security find-generic-password -w -a "${LOGNAME}" -s qar-salt)
  fi
}
export -f get_salt >/dev/null 2>&1

set_passcode $1
set_salt $1
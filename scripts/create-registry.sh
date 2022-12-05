#!/bin/bash

##################################################################
##                                                              ##
##             Script for creating registry                     ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode="$(get_passcode $1)"

echo "Do you need to create nonce?"
read -p "[y/N] " -r yn
case $yn in
  "Y" | "y")
    kli nonce
    ;;
  *)
    ;;
esac
echo ""
read -p "Enter nonce: " -r nonce

kli vc registry incept  --name "${QAR_NAME}" --passcode "${passcode}"  --alias "${QAR_AID_ALIAS}" --registry-name "${QAR_REG_NAME}" --nonce "${nonce}"

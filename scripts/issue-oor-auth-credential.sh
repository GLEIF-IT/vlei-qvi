#!/bin/bash

##################################################################
##                                                              ##
##          Script for issuing oor auth                         ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode="$(security find-generic-password -w -a "${LOGNAME}" -s int-gar-passcode)"

read -p "Enter your LEI : " -r lei
read -p "Enter or Paste the AID of the recipient of the OOR credential: " -r AID
read -p "Enter requested person legal name: " -r personLegalName
read -p "Enter requested official role: " -r officialRole
read -p "Enter the Alias of the QVI to authorize with this AUTH credential: " -r recipient


# Prepare the DATA section
echo "[\"${AID}\", \"${lei}\", \"${personLegalName}\", \"${officialRole}\"]" | jq -f "${INT_GAR_SCRIPT_DIR}/oor-auth-data.jq" > "${INT_GAR_DATA_DIR}/oor-auth-data.json"

# Prepare the EDGES Section
le_said=$(kli vc list --name "${INT_GAR_NAME}" --passcode "${passcode}" --alias "${INT_GAR_AID_ALIAS}" --said --schema ENPXp1vQzRF6JwIuS-mp2U8Uf1MoADoP_GqQ62VsDZWY  | tr -d '\r')

echo "\"${le_said}\"" | jq -f "${INT_GAR_SCRIPT_DIR}/oor-auth-edges-filter.jq" > "${INT_GAR_DATA_DIR}/oor-auth-edge-data.json"
kli saidify --file /data/oor-auth-edge-data.json

# Prepare the RULES section
cp "${INT_GAR_SCRIPT_DIR}/rules.json" "${INT_GAR_DATA_DIR}/rules.json"

kli vc issue --name "${INT_GAR_NAME}" --passcode "${passcode}" --alias "${INT_GAR_AID_ALIAS}" --registry-name "${INT_GAR_REG_NAME}" --schema EKA57bKBKxr_kN7iN5i7lMUxpMG-s19dRcmov1iDxz-E --recipient "${recipient}" --data @"/data/oor-auth-data.json" --edges @"/data/oor-auth-edge-data.json" --rules @"/data/rules.json" --out "/data/credential.json"

#!/bin/bash

##################################################################
##                                                              ##
##          Script for issuing legal entity oor                 ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode="$(get_passcode $1)"

read -p "Legal name of person who will hold OOR credential: " -r personLegalName
read -p "Alias that identifies them in your contacts: " -r recipient
read -p "Their official role: " -r officialRole
read -p "LEI of the Legal Entity for this OOR: " -r lei
read -p "SAID of the OOR AUTH credential: " -r auth_said

# Create DATA block
echo "[\"${lei}\", \"${personLegalName}\", \"${officialRole}\"]" | jq -f "${QAR_SCRIPT_DIR}/legal-entity-oor-data.jq" > "${QAR_DATA_DIR}/legal-entity-oor-data.json"

echo "\"${auth_said}\"" | jq -f "${QAR_SCRIPT_DIR}/legal-entity-oor-edges-filter.jq" > "${QAR_DATA_DIR}/legal-entity-oor-edge-data.json"
kli saidify --file data/legal-entity-oor-edge-data.json

# Prepare the RULES section
cp "${QAR_SCRIPT_DIR}/rules.json" "${QAR_DATA_DIR}/rules.json"

kli vc issue --name "${QAR_NAME}" --passcode "${passcode}" --alias "${QAR_AID_ALIAS}" --registry-name "${QAR_REG_NAME}" --schema EBNaNu-M9P5cgrnfl2Fvymy4E_jvxxyjb70PRtiANlJy --recipient "${recipient}" --data @"data/legal-entity-oor-data.json" --edges @"data/legal-entity-oor-edge-data.json" --rules @"data/rules.json" --out "data/oor.json"
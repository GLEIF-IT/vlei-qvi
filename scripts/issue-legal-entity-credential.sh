#!/bin/bash

##################################################################
##                                                              ##
##        Script for issuing legal entity credential            ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode="$(get_passcode $1)"

read -p "Enter the LEI of the new Legal Entity: " -r lei
read -p "Enter the alias of the new Legal Entity: " -r recipient

# Create DATA block
echo "\"${lei}\"" | jq -f "${QAR_SCRIPT_DIR}/legal-entity-data.jq" > "${QAR_DATA_DIR}/legal-entity-data.json"

# Create EDGES block
qvi_said=$(kli vc list --name "${QAR_NAME}" --passcode "${passcode}" --alias "${QAR_AID_ALIAS}" --said --schema EBfdlu8R27Fbx-ehrqwImnK-8Cm79sqbAQ4MmvEAYqao)

echo "\"${qvi_said}\"" | jq -f "${QAR_SCRIPT_DIR}/legal-entity-edges-filter.jq" > "${QAR_DATA_DIR}/legal-entity-edge-data.json"
kli saidify --file /data/legal-entity-edge-data.json

# Prepare the RULES section
cp "${QAR_SCRIPT_DIR}/rules.json" "${QAR_DATA_DIR}/rules.json"

kli vc issue --name "${QAR_NAME}" --passcode "${passcode}" --alias "${QAR_AID_ALIAS}" --registry-name "${QAR_REG_NAME}" --schema ENPXp1vQzRF6JwIuS-mp2U8Uf1MoADoP_GqQ62VsDZWY --recipient "${recipient}" --data @"/data/legal-entity-data.json" --edges @"/data/legal-entity-edge-data.json" --rules @"/data/rules.json" --out "/data/credential.json"

#!/bin/bash

##################################################################
##                                                              ##
##          Script for issuing legal entity ecr                 ##
##                                                              ##
##################################################################

PWD=$(pwd)
source $PWD/source.sh

# Capture password
passcode="$(get_passcode $1)"

read -p "Enter the LEI of the new Legal Entity: " -r lei
read -p "Enter person legal name: " -r personLegalName
read -p "Enter engagement context role: " -r engagementContextRole
read -p "Enter the alias of the recipient of ECR credential: " -r recipient

# Create DATA block
echo "[\"${lei}\", \"${personLegalName}\", \"${engagementContextRole}\"]" | jq -f "${QAR_SCRIPT_DIR}/legal-entity-ecr-data.jq" > "${QAR_DATA_DIR}/legal-entity-ecr-data.json"

# Create EDGES block
le_said=$(kli vc list --name "${QAR_NAME}" --passcode "${passcode}" --alias "provenant-le" --said --schema ENPXp1vQzRF6JwIuS-mp2U8Uf1MoADoP_GqQ62VsDZWY)

echo "\"${le_said}\"" | jq -f "${QAR_SCRIPT_DIR}/legal-entity-ecr-edges-filter-as-le.jq" > "${QAR_DATA_DIR}/legal-entity-ecr-edge-data.json"
kli saidify --file data/legal-entity-ecr-edge-data.json

# Prepare the RULES section
cp "${QAR_SCRIPT_DIR}/rules.json" "${QAR_DATA_DIR}/rules.json"

kli vc issue --name "${QAR_NAME}" --passcode "${passcode}" --alias "${QAR_AID_ALIAS}" --registry-name "${QAR_REG_NAME}" --schema EEy9PkikFcANV1l7EHukCeXqrzT1hNZjGlUk7wuMO5jw --recipient "${recipient}" --data @"data/legal-entity-ecr-data.json" --edges @"data/legal-entity-ecr-edge-data.json" --rules @"data/rules.json" --out "data/ecr.json"

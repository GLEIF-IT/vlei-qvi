
##################################################################
##                                                              ##
##        Setup local environment as an External QAR            ##
##                                                              ##
##################################################################

# Pull container required to run all KERI/ACDC commands
docker pull gleif/keri:0.6.7

# Create local directory for datastore, keystore and configuration
mkdir -p "${HOME}"/.qar/cf

# Protect directory from others
chmod 700 "${HOME}"/.qar

# Copy AID configuration information for loading
cp -R scripts/keri/cf/ ~/.qar/cf


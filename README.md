
# QVI Authorized Representative (QAR)

This package contains documentation and Bash shell scripts needed to use the KERIpy command line tool (`kli`) to
participate as a QVI Authorized Representative (QAR) as a member of a QVI Autonomic Identifier (AID).

## Repository Layout
This repository contains documentation in the `./docs` directory and Bash shell scripts in the `./scripts` directory.  The 
scripts make it easy to use the KERI command line tool `kli` to perform all functions required of a QAR.  It utilizes the KERI
docker image `gleif/keri:0.6.7` with mounts to local directories to minimize the requirements on the local system.  

## Getting Started
The steps needed to bootstrap your system are described in [Getting Started](./docs/getting-started.md).  After following
the steps described in that document you will have a KERI datastore and keystore encrypted using a randomly generated passcode
that is automatically stored in your Mac keychain.  

From there you will be ready to join and participate in a Group Multisig AID as described in [Creating Group AID](./docs/creating-group-aid.md).

## Passcode and salt management

In the vLEI Ecosystem your salt (used to create a deterministic public/private key pair) and passcode are as vital as your private keys. 
KERI has a multi-layer security profile to protect your private keys.

As a result there are multiple options to protect your salt and passcode:

* `--insecure` development only
* `--kc` utilizes the macOS keychain ([further reading](https://support.apple.com/guide/security/keychain-data-protection-secb0694df1a/web))
* `--op` utilizes 1Password CLI ([further reading](https://support.1password.com/getting-started-linux/))

## Further Reading
The following table contains reference material and repository links for the vLEI schema, the KERI protocol and ACDC
credentials, all foundational concepts and technologies for GLEIF's vLEI ecosystem:

| Acronym      | Full Name of Deliverable | Link to Deliverable                                                               | Lead Authors | Status / Notes |
|--------------|---|-----------------------------------------------------------------------------------|---|---|
| KERI         | Attributable (Autonomic) Identifiers (KERI) | [IETF KERI Draft](https://github.com/WebOfTrust/ietf-keri)                        | Samuel Smith | |
| vLEI EGF | vLEI Ecosystem Governance Framework | [vLEI EGF](https://github.com/GLEIF-IT/vlei-egf)                                                                      | Karla McKenna / Drummond Reed | | 
| vLEI Schema  | The published JSON schema for all vLEI credentials | [vLEI Schema](https://github.com/WebOfTrust/vLEI)                                 | Phil Feaihreller / Kevin Griffin | |
| SAID         | Self-Addressing Identifiers | [IETF SAID Draft](https://github.com/WebOfTrust/ietf-said)                        | Samuel Smith | [Active Draft](https://datatracker.ietf.org/doc/draft-ssmith-said/) |
| ACDC         | Authentic Chained Data Containers | [IETF ACDC Draft](https://github.com/trustoverip/tswg-acdc-specification)         | Samuel Smith | [Active Draft](https://datatracker.ietf.org/doc/draft-ssmith-acdc/) |
| OOBI         | Out-Of-Band-Introduction | [IETF OOBI Draft](https://github.com/WebOfTrust/ietf-oobi)                        | Sam Smith ||
| CESR         | Composable Event Streaming Representation | [IETF CESR Draft](https://github.com/WebOfTrust/ietf-cesr)                        | Samuel Smith |[Active Draft](https://datatracker.ietf.org/doc/draft-ssmith-cesr/)|
| CESR Proof   | CESR Proof Signatures | [IETF CESR Proof Signatures Draft](https://github.com/WebOfTrust/ietf-cesr-proof) | Phil Feairheller | [Active Draft](https://datatracker.ietf.org/doc/draft-pfeairheller-cesr-proof/) | 
| PTEL         | Public Transaction Event Logs | [IETF PTEL Draft](https://github.com/WebOfTrust/ietf-ptel)                        | Phil Feairheller | [Active Draft](https://datatracker.ietf.org/doc/draft-pfeairheller-ptel/)| 


## Utility Scripts
There are several scripts located in the `scripts` directory that are described specifically in any flow documentation
but are provided as utilities that can be helpful for QAR controllers while participanting in the vLEI ecosystem.  The
following table describes the scripts, all of which can be used any time after the steps described in [Getting Started](./docs/getting-started.md)

| Script | Purpose |
|--------|---------|
| `./scripts/status.sh` | AID status script that can be used to inspect key state of any local AID |
| `./scripts/contacts.sh` | Script to list any contacts locally resolved through OOBI exchange.  Indicates Authentication status |

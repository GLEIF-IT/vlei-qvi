
# Getting Started
This document describes the steps required to bootstrap your system using the scripts in this repository to act as 
a QVI Authorized Representative (QAR) and member of either the GLEIF External AID or GLEIF Internal AID, both of which
will be KERI group multisig AIDs.


## Initial Installation
The steps described in this section only need to be performed once to prepare your system to run the required software to
perform as a QAR.

### Prerequisites
The software in this repository is designed to run on MacBook Pro laptops with macOS Monterey (ver 12.6).

The following five software packages are required to execute the scripts in this repository:

- Homebrew (brew) - The Missing Package Manager for macOS
- Docker Desktop on Mac
- Bash - the Bourne Again SHell
- jq - `sed` for JSON data
- git - distributed version control system

Installation instructions for Homebrew (`brew`) can be found here: https://brew.sh.
Installation instructions for Docker Desktop can be found here: https://docs.docker.com/desktop/install/mac-install/.  
Bash should be installed by default on your MacOS computer.  
Installation instructions for `jq` can be found here: https://stedolan.github.io/jq/download, utilize the brew command.
Installation instructions for `git` can be found here: https://git-scm.com/download/mac, utilize the brew command.

### System Setup
The scripts in this package rely on the KERIpy docker image `gleif/keri` hosted on docker hub.  The first step is to execute the
following script once, the first time you prepare to use this package:

```bash
$ ./scripts/prepare.sh
```

The output should resemble:

```bash
0.6.7: Pulling from gleif/keri
Digest: sha256:5dead12388be0a814c00044369a2dc52465318af329b1c7f4956810c83ae4e6c
Status: Image is up to date for gleif/keri:0.6.7
docker.io/gleif/keri:0.6.7

```

This script will perform a docker pull for the KERIpy image as well as creating your local directory that stores the
datastore, keystore and configuration information generated as a QAR.  You will not need to run this script again.

The final step in system setup is to edit the `source.sh` initialization script and set two values used as exported environment
variables in the rest of the scripts.  At the top of the file there are two exported environment variables:

```bash
# Change to the name you want to use for your local database environment.
export QAR_NAME="External QAR"

# Change to the name you want for the alias for your local External QAR AID
export QAR_ALIAS="John Doe"
```

Change these values in `source.sh` to the names you want to use for your database directory and local AID alias respectively.
These values are local to you and not exposed to anyone else so they just need to be values that make sense for you.  We recommend
leaving `QAR_NAME` as it currently is and changing `QAR_ALIAS` to your full name.


## Environment Initialization
Each time you wish to perform a function as a QAR you must initialize your shell environment to gain access to your 
keystore and the KERIpy `kli` command.  You should always start with a new Terminal (or new shell in an existing terminal application)
and source the following script from the root directory of this repository using this command:

```bash
$ source ./source.sh
```

This script performs several functions.  The first time it is sourced it will create a random passcode and a random
salt and store both in your Mac Keychain.  The random passcode is use to encrypt your keystore and must be provided for all
subsequent calls to the `kli` tool (the rest of the scripts do this for you).  The salt is used to initialize the hierachical
deterministic keychain of private keys for your wallet.  This can be used to recover your set of private keys in the event
of a keystore loss.  All subsequent executions of this script will ensure the passcode and salt are stored in your keychain
and will not recreate them

The `source.sh` script also initializes several environment variables used by the rest of the scripts as well as a Bash
function for `kli` that executes the docker image as a throw away container for each command run.

## Create Your Local AID
As a QVI Authorized Representative you will be a member of the group multisig AID for either the GLEIF External AID or
the GLEIF Internal AID.  To participate as a member of a group multisig, you must first create your local AID that will contribute 
its public key to the set of public keys that comprise the group mutlsig.  After initializing your system and sourcing `source.sh` the
next step is to execute the following script to create your local AID:

```bash
$ ./scripts/create-local-aid.sh
```

The output from this script should resemble:

```bash
KERI Keystore created at: /usr/local/var/keri/ks/External QAR
KERI Database created at: /usr/local/var/keri/db/External QAR
KERI Credential Store created at: /usr/local/var/keri/reg/External QAR
        aeid: BH5EBuQCjPGP0g96-7cH-Q8-sazWtD6OCH_AWdAtpadp

Loading 5 OOBIs...
http://13.245.160.59:5623/oobi?name=gleif-3 succeeded
http://139.99.193.43:5623/oobi?name=gleif-1 succeeded
http://20.3.144.86:5623/oobi?name=gleif-2 succeeded
http://47.242.47.124:5623/oobi?name=gleif-4 succeeded
http://49.12.190.139:5623/oobi?name=gleif-0 succeeded
Waiting for witness receipts...
Prefix  EHlegxGzgOsBLZQZJSUQW-vKwgeOo8YPcNMJIgTJO82Q
        Public key 1:  DBMaw34egBlM_lD4x4id0DTF4ZnTeUf4o4zLs48ohN2c

Alias:  John Doe
Identifier: EHlegxGzgOsBLZQZJSUQW-vKwgeOo8YPcNMJIgTJO82Q
Seq No: 0

Witnesses:
Count:          5
Receipts:       5
Threshold:      5

Public Keys:
        1. DBMaw34egBlM_lD4x4id0DTF4ZnTeUf4o4zLs48ohN2c
```

A few items are important to understand.  You should see that the path of the Keystore, Datastore and Credential Store
all end with the name specified in the `QAR_NAME` environment variable.  In addition, all the paths are rooted at `/usr/local/var/keri`
in the output.  That is because we are using a docker container to execute the commands mounted with `/usr/loca/var/keri` to
the local path `$HOME/.qar`.  

Some values that will be different in your output to the sample here include the witness IP addresses and name parameters,
the number of witnesses and the AID (Prefix:) and Public Key values.  The value for "Alias" should be the value you specified
in `source.sh` as the `QAR_ALIAS` environment variable.

If at any time you want to see this output again to see the current state of your AID you can execute the following:

```bash
$ ./scripts/status.sh
```

## Next Steps
Now that your system is initialized, you are ready to proceed to the next step in the process of being a QAR, ["Create GLEIF
Group Multisig AID"](creating-group-aid.md).





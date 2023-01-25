
# Presenting credentials to vLEI Reporting API

To present a credential, you must perform the following steps that will connect you to the GLEIF vLEI Reporting API, discover
the self-addressing identifier (SAID) of the credential to present, then present the credential.  

## Connecting with vLEI Reporting API

The first step in the process is to connect to the vLEI Reporting API by resolving the well known out-of-bounds
introduction (OOBI) of the autonomic identifier (AID) of the vLEI Reporting API.  You will resolve the OOBI
(https://vlei-reporting.gleif.org/oobi) using the `resolve-oobi.sh` script:


```bash
$ ./scripts/resolve-oobi.sh
```

First, this script will prompt you for URL of the OOBI you wish to resolve, paste `https://vlei-reporting.gleif.org/oobi`
at this prompt:

```bash
Type or paste OOBI URL: https://vlei-reporting.gleif.org/oobi
```

After you paste the OOBI of the GLEIF vLEI Reporting API, the script will prompt you to enter an Alias for this OOBI.  
This alias will be your local "nickname" for the AID that is resolved from the OOBI.  It is local to you and not shared 
so you should use a name that will uniquely identify the GLEIF vLEI Reporting API.  We suggest using `vlei-reporting-api`.
Once you type the alias and hit enter the system should indicate that the OOBI was resolved and show you the Alias and AID
that was just created in your datastore.

This step in the credential presentation process only needs to be performed ONCE, the first time you present a credential.

## List Credentials
Once you have resolved the GLEIF vLEI Reporting API OOBI, you will need to get the SAID of the credential to present.  
You will use the `list-credentials.sh` command to show all credentials you have either received or issued.  By default, 
this command will list your received credentials and can be executed as follows:

```bash
$ ./scripts/list-credentials.sh
```

To list the credentials you have issued, you add the `--issued` options:

```bash
$ ./scripts/list-credentials.sh --issued
```

When you present your QVI credential, you will list credentials you have received.  When you present any Legal Entity or 
Official Organizational Role credential, you will list credentials you have issued.  The command will ask which of your
local AIDs you wish to list credentials for.  Select the number of your group multisig QVI AID.  The output will be as follows:

```bash
Enter the number of your local AID to use:
	1: My QVI (EFcrtYzHx11TElxDmEDx355zm7nJhbmdcIluw7UMbUIL)
	2: Phil Feairheller (EIwP58RHVThBaHqLbANVuC19HkjI5ksg0fl2nPth2yZB)
Number: 1
Checking mailboxes for any issued credentials.....

Current issued credentials for GLEIF Internal (EFcrtYzHx11TElxDmEDx355zm7nJhbmdcIluw7UMbUIL):

Crecential #1: EHWEdU7GMOOQZlhjtGaV_5689WmfWIu4C5gc9Iy7TwH2
    Type: Legal Entity Official Organizational Role vLEI Credential
    Status: Issued ✔
    Issued by EFcrtYzHx11TElxDmEDx355zm7nJhbmdcIluw7UMbUIL
    Issued on 2022-12-09T17:41:25.604911+00:00```

Crecential #2: EBhBRqVbqhhP7Ciah5pMIOdsY5Mm1ITm2Fjqb028tylu
    Type: Legal Entity vLEI Credential
    Status: Issued ✔
    Issued by EFcrtYzHx11TElxDmEDx355zm7nJhbmdcIluw7UMbUIL
    Issued on 2022-12-10T08:41:25.604911+00:00```
    
```

Select the SAID of the credential to present, listed on the first line of output for each credential in the list.

## Present Credential
The final step is to use the `present.sh` script to present the credential to the GLEIF vLEI Reporting API.  The script is
executed as follows:

```bash
./scripts/present.sh
```

The script will ask for the SAID of the credential to present and the alias (or AID) of the recipient of the presentation:

```bash
Enter the SAID of the credential to present: EBhBRqVbqhhP7Ciah5pMIOdsY5Mm1ITm2Fjqb028tylu
Enter the AID or alias of the recipient of the presentation: vlei-reporting-api
```

After entering those two bits of information, a signed credential presentation message has been sent to the GLEIF vLEI Reporting
API after the command finishes:

```bash
Enter the SAID of the credential to present: EBhBRqVbqhhP7Ciah5pMIOdsY5Mm1ITm2Fjqb028tylu
Enter the AID or alias of the recipient of the presentation: vlei-reporting-api

Presentation Sent
```


As a QVI, you will be responsible for presenting your QVI credential one time after receiving it and for presenting
each Legal Entity credential and Official Organizational Role credential that you issue to your clients.



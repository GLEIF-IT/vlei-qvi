
# Create QVI Group Multisig AID

Once all members of a given QVI Group Multisig AID have created their local AIDs
as described in [Getting Started](getting-started.md) the group multisig AID can be created using the following steps.

1. Join a Video Call with all other GARs.
2. Send your OOBI over video call.
3. Receive OOBIs over video call.
4. Send challenge message to others.
5. Receive challenge messages.
6. Configure and join the multisig group.


All members must complete the first 5 steps as described below.  Once that has been completed, one member of the group must
be selected as the Lead.  The Lead is responsible for running the Group Multisig Shell to generate the configuration file
for the group multisig AID and initiate the inception with that configuration file.  All other members will join the multisig
group once they receive the notification from the Lead.  The rest of this document describes the entire process.
         
## Join Video Call
The vLEI Ecosystem Governance Framework (vLEI EGF) mandates that all participants in the QVI AIDs must perform NIST-800-63-3 IAL-2 identity
assurance with all other participants in their group multisig.  In addition, once that is complete the members are required to join
a live video call with all other participants and present Out-of-band Introductions (OOBIs) and exchange signed challenge messages in the 
same live session to satisfy the 2-factor identity authentication requirements.  The video sessions can be one-to-one video calls
between each participant-pair or one video call with all participants in the same session.  It is important during the video call to follow
the steps defined in the rest of this document to ensure proper compliance with the identity authentication requirements of the vLEI EGF.

## Send and Receive OOBIs
Each participant in the group multisig must generate an OOBI and paste their OOBI in the video call chat for all other participants
to resolve.  To generate an OOBI for your local AID, run the following script:

```bash
$ ./scripts/generate-oobi.sh
```

This script will use your local AID by default and generate all "witness OOBIs" that are valid for that AID.  The output should 
look similar to the following (except for AID values and IP addresses):

```bash
http://49.12.190.139:5623/oobi/EHlegxGzgOsBLZQZJSUQW-vKwgeOo8YPcNMJIgTJO82Q/witness/BILZrnru0e-0MUmnnjOdWTrZ7OW3sCuk_C_67uYeLsN_
http://139.99.193.43:5623/oobi/EHlegxGzgOsBLZQZJSUQW-vKwgeOo8YPcNMJIgTJO82Q/witness/BN6TBUuiDY_m87govmYhQ2ryYP2opJROqjDkZToxuxS2
http://20.3.144.86:5623/oobi/EHlegxGzgOsBLZQZJSUQW-vKwgeOo8YPcNMJIgTJO82Q/witness/BBD748wGFn9-1nfVEtfwd97wc-HCw0LRF2xeIujmqJOQ
http://13.245.160.59:5623/oobi/EHlegxGzgOsBLZQZJSUQW-vKwgeOo8YPcNMJIgTJO82Q/witness/BHeD7WvSDGwm0glBHGTuHpGeMRq7HyCOAJ8h_epQyHkR
http://47.242.47.124:5623/oobi/EHlegxGzgOsBLZQZJSUQW-vKwgeOo8YPcNMJIgTJO82Q/witness/BBHjAqI2Bf_L6BtR0ueAGf12GXEKKCPo2etRCjuu87U7
```
Copy any one (and only one) of the URLs displayed in the output and paste it into the chat window of the live video session.  For
each of the other participants in your group multisig, you will need to resolve their OOBI that they have pasted into the video
chat and assign them a local alias that you will use to refer to them in your local QAR environment.  

For each participant, copy their URL from the video chat and run the following command:

```bash
$ ./scripts/resolve-oobi.sh
```

First, this script will prompt you for URL of the OOBI you wish to resolve (ensure this is not your own URL):

```bash
Type or paste OOBI URL:
```

After you paste your OOBI the script will prompt you to enter an Alias for this OOBI.  This alias will be your local "nickname" 
for the AID that is resolved from the OOBI.  It is local to you and not shared so you should use a name that will uniquely 
identify the controller of the AID to you.  Once to type the alias and hit enter the system should indicate that the OOBI
was resolve and show you the Alias and AID that was just created in your datastore.

```bash
Type or paste OOBI URL: http://20.3.144.86:5623/oobi/EHlegxGzgOsBLZQZJSUQW-vKwgeOo8YPcNMJIgTJO82Q/witness/BBD748wGFn9-1nfVEtfwd97wc-HCw0LRF2xeIujmqJOQ
Enter an Alias for the AID: John Doe

http://20.3.144.86:5623/oobi/EHlegxGzgOsBLZQZJSUQW-vKwgeOo8YPcNMJIgTJO82Q/witness/BBD748wGFn9-1nfVEtfwd97wc-HCw0LRF2xeIujmqJOQ resolved

Alias: John Doe
AID:   EHlegxGzgOsBLZQZJSUQW-vKwgeOo8YPcNMJIgTJO82Q
```

You must perform this step with each other participant in your group to retrieve their key event log for their AID and 
associate an Alias with their AID.  When this is complete you'll have a local "contact" entry for each other participant and while
still on the save live video session you can move on to the next step to authenticate these contacts.

## Send and Receive Challenge Messages
In the same live session as the OOBI exchange, participants must challenge each other participant with a 12-word challenge
phase that the other participant must sign and return.  This ensures that the other participants in the group are the
sole controller of the private key of the AID resolved during the OOBI exchange protocol.

To challenge all the other participants in your group, you must generate a random challenge phrase using the 
following command and paste it in a PRIVATE chat with the other participant.  The script will prompt you for the Alias
of the other participant you are challenging and display the 12-word phrase.  The script will then wait for the other
participant to use their system to sign the phrase (described below) and return it to you using a KERI peer-to-peer
protocol message.  Once you have recieved a valid signed challenge response containing the 12-word phrase from the other 
participant.

#### Note:

---

*Each participant should generate a unique challenge phrase for each of the other participants*

*There should only be one member of the group running `generate-challenge.sh` at once.*

---

```bash
$ ./scripts/generate-challenge.sh
```

The script will prompt you for the Alias, display the unique 12-word challenge for this participant and indicate that it
is waiting for a valid response (the 12-word phase will be different every time).

```bash
$ ./scripts/generate-challenge.sh
Enter the Alias to whom you will send the words: John Doe
rice jewel into dance bean stadium west sister auto cupboard repair daughter
Checking mailboxes for any challenge responses...
```

You need to copy the second line from the output and paste it in a private chat to the participant you indicated with 
the Alias you typed.  Once that participant signs the response this script will authenticate the contact in your database
and display the authenticated contact information.  You must verbally tell the other participant that you received a successful
signed response to your challenge:

```bash
Signer John Doe successfully responded to challenge words: ["rice", "jewel", "into", "dance", "bean", "stadium", "west", "sister", "auto", "cupboard", "repair", "daughter"]
```

During this process you will also be challenged with unique 12-word challenges that you must sign and return to the
originator or the challenge.  When you receive a 12-word challenge from another participant you must sign it and return
that signed response to the other participant using the following command:

```bash
$ ./scripts/respond-to-challenge.sh
```

This script is similar to the script used to resolve an OOBI earlier.  It will first prompt you to type or paste the 12-word
challenge and then it will ask for the Alias of the AID who sent you challenge:

```bash
./scripts/respond-to-challenge.sh
Type or paste challenge sent to you: rice jewel into dance bean stadium west sister auto cupboard repair daughter
Enter the Alias who sent you the words: John Doe
Challenge phrase signed and sent
```

This will sign the 12-word challenge using the private key of your local AID and send the result back to the participant
who pasted it in chat for you.  The other participant will verbally confirm that they received your signed response and
you can move on to challenging and responding with all other participants in the group.

When you are finished with this process with each other participant in your group you can verify that you have authenticated
contacts using the ultity script `./scripts/contacts.sh` which will display the contact, their AID and the authenticated
state of that contact.  

## Configure Group Multisig
As mentioned earlier in the document, once the OOBI and challenge response phase has been completed for every participant
pair in the group (everyone has authenticated contacts for everyone else), a Lead must be selected from the group to perform 
the step of configuring the multisig group and generating and sending the inception event to everyone else.  The KERI
Interactive Multisig Shell (KIMS) was written to simplify the process of creating the configuration file needed to incept a group
multisig AID with other contacts in your database.  You launch KIMS using this script:

```bash
$ ./scripts/multisig-shell.sh
```

KIMS is a prompt driven interactive shell with a full help system for all available commands.  Launching the command
and entering a `?` into the prompt will guide you through the documentation for each command.

```bash
$ ./scripts/multisig-shell.sh
Welcome to the KERI interactive multisig shell.   Type help or ? to list commands.

(kims) ?

Documented commands (type help <topic>):
========================================
add  delegator  exit  help  save  show  threshold

(kims)
```

In addition to the help subsystemn, KIMS included autocomplete functionality for both available commands as well as information
needed to complete commands such as local aliases and contacts in your database.

As mentioned in the last section, KIMS support completion of commands and of contact aliases in certain contexts.  You can test 
this now by typing `dele` at the `(kims)` prompt and hitting the TAB key.

### Adding Local AID
Since the Lead QAR is the one creating the multisig configuration, you should add your local AID as the first participant
in the group multisig aid.  Use the `add local` command to add the local AID you created in "Getting Started".  If you don't
remember the Alias you provided, you can hit the TAB key twice after add a space after `add local` to show your the aliases
for your local AIDs.  

The vLEI EGF also mandates that the QVI AIDs should all use fractionally weighted thresholds.  This means that for each participant
(local or contact) that you add you must specify a fractional value in the form "numerator / denominator" where both numerator
and denominator are integers.  When fractionally weighted thresholds are used an event is not considered valid
until enough participants sign the event such that the sum of their fractional thresholds equals at least 1.  You will be 
provided the threshold for each member in your QVI Group Multisig AID prior to beginning this procedure.

To add your local AID named "John Doe" with a threshold of "1/2", the command would look like
the following (where you typed in John Doe and then "1/2" in response to the "Enter threshold" prompt):

```bash
(kims) add local John Doe
John Doe AID ECoiGGWOxOyD9oHllZ_7_olzZRC4hEpkrQfQDeDzmRBb added to participants
        Enter threshold: 1/2
(kims)
```

### Adding Other Participants.
You will now add the other participants in your group multisig to the configuration.  To do so you follow the same
process as you did for adding your local AID except the command is `add participant` instead of `add local`.  So to add
a contact from your database named "Christoph Schneider" with a threshold of "1/5" use the following command:

```bash
(kims) add participant Christoph Schneider
Christoph Schneider AID EJw8ONOH5-BjWxxaX1ltYt4dKbcyxTDlQ8xxvXT57hk2 added to participants
        Enter threshold: 1/5
(kims)
```

You will continue this procedure until you have added all the participants with their thresholds to the configuration 
for your group multisig AID.

### Adding Witnesses
Witnesses are an additional security threshold added to KERI AIDs to increase the difficulty of a success attack against
an AID.  KIMS allows you to configure witnesses for your group multisig AID with the `add witness` command.  The configuration
information loaded when you created your database environment included OOBIs for the witnesses in the QVI provided vLEI
Witness Network.  Those witnesses were loaded and assigned aliases to uniquely identify each witness by region and cloud
provider.  The configuration for the QVI AIDs is required to contain a diverse set of witnesses across region and cloud
provider.  You will be provided with the list of witness names you are to add in this step.  To add a witness, use the following command:

```bash
(kims) add witness witness-1
witness-1 AID BBilc4-L3tFUnfM_wJr4S4OJanAv_VmF_dJNN6vkf2Ha added to witnesses
(kims)
```

Perform the `add witness` command for each of the witnesses in the list you were provided.  Remember that you can hit the
TAB key when entering witness names to see possible completions and ensure you are entering the correct names.

## Saving Configuration
Before saving the configuration to a file you should inspect the JSON file to ensure you have entered all the values
correctly.  You can use the `show` command to print the configuration on screen.

```bash
(kims) show
{
  "aids": [
    "ECoiGGWOxOyD9oHllZ_7_olzZRC4hEpkrQfQDeDzmRBb",
    "EJw8ONOH5-BjWxxaX1ltYt4dKbcyxTDlQ8xxvXT57hk2",
    "EOGnH55mIQoH9gFe6FkcwsD_JQTpXX9wigP9IdaeZsLJ",
    "EEOX0YKCB8M1ggEqDcuGdixMORqAy9mOtpQTukvuyjW5",
    "EA4WzEqv6abwYUuiscw7uSKcZwIV2bY6NPaOXoI1ER8M",
    "EKVNrcjJ0B70hbFsKZyW3NL3i2I2OUE8HBzJrfoDCrLC",
    "EO2pY9xwjiqFIokbFKMRuNIOSFNYrGQo_x85_xEvJBEa"
  ],
  "transferable": true,
  "wits": [
    "BBilc4-L3tFUnfM_wJr4S4OJanAv_VmF_dJNN6vkf2Ha",
    "BLskRTInXnMxWaGqcpSyMgo0nYbalW99cGZESrz3zapM",
    "BIKKuvBwpmDVA4Ds-EpL5bt9OqPzWPja2LigFYZN2YfX",
    "BDjY4jRiYqKr_FPTt3MlK6tDUEUCAVL4pyI-t1RPwXP_",
    "BBpePuOUCrLGcu_L6cVKtVFk1KebGyL-9kROE9OmrWmj"
  ],
  "toad": 5,
  "isith": [
    "1/2",
    "1/2"
    "1/5",
    "1/5",
    "1/5",
    "1/5",
    "1/5",
  ],
  "nsith": [
    "1/2",
    "1/2"
    "1/5",
    "1/5",
    "1/5",
    "1/5",
    "1/5",
  ]
}
```

This shows the full configuration that will be passed to the Inception command to create the group multisig AID.  You need
ensure that the AIDs are in the correct order based on the list you were provided and that the threshold fractions match
the order in the list as well.  You also need to ensure that you entered all the witnesses from the list you were provided.
The order of witnesses is not important.  The rest of the configuration information is selected from default values and
is correct for the QVI AIDs.

Once you have confirmed all the information in the configuration, you must save it to a file.  Because the scripts in
this repository are using a Docker container to execute the KERI functions you must save this file in a location that
the docker container will recognize and that is mapped to a local directory.  The file name you provide must start with
"/data" so it is saved in the "./data" directory relative to the root of this repository.  Doing so will make the file
accessible to the subsequent command that needs it.

Assuming you wish to save this file with the name "qar-aid-inception.json" you would use the `save` command in
KIMS as follows:

```bash
(kims) save /data/qar-aid-inception.json
```

Once saved, you can exit KIMS by typing `exit` and hitting ENTER or by hitting CTRL-C from the `(kims)` prompt.

### Submitting the Group Multisig AID Inception Event
As the Lead QAR, now that you have created the inception configuration file for the group multisig AID you need to use the
KERI system to create the inception event (thus creating the AID) and submit it to the other participants of the group. 
You will use the `multisig-incept.sh` script to intiate the process.  The script will prompt you for the local alias of the
new group multisig AID and for the filename created in the last step.  Remember that the filenames are relative to the
docker container and must start with "/data".

Assuming the configuration file created in the last step and an Alias of "QVI AID", the command initiation will 
look like the following:

```bash
$ ./scripts/multisig-incept.sh
Enter an Alias for the Group Multisig AID: QVI AID
Enter the filename of the inception configuration file: /data/qar-aid-inception.json
Group identifier inception initialized for EDgkEWEfAnHTNmbHj4oJvOfYyFJC93lJ19WB2GOwFaNI
Sending multisig event to 6 other participants
Waiting for other signatures for 0...

```

At this point you must leave this script running as it waits for the other participants in the group to join the group
multisig AID (described in the next section for all other participants).

```bash
$ ./scripts/multisig-incept.sh
Enter an Alias for the Group Multisig AID: QVI AID
Enter the filename of the inception configuration file: /data/qar-aid-incept.json
Group identifier inception initialized for EDgkEWEfAnHTNmbHj4oJvOfYyFJC93lJ19WB2GOwFaNI
Sending multisig event to 6 other participants
Waiting for other signatures for 0...
Waiting for delegation approval...
We are the fully signed witnesser 0, sending to witnesses
Waiting for fully signed witness receipts for 0

Alias:  QVI AID
Identifier: EDgkEWEfAnHTNmbHj4oJvOfYyFJC93lJ19WB2GOwFaNI
Seq No: 0

Group Identifier
    Local Indentifier:  EHpJf8dVzrotWFmgWE9ouFunIqHqvmg3TZuFuLzp9sqf ✔ Fully Signed

Witnesses:
Count:          5
Receipts:       5
Threshold:      5

Public Keys:
        1. DFggExZfu3MGXrU1q6QdeaiBqeciMtLippy5htuKZV3G
        2. DHxmDwyt-TnQM0tNvyYmCogJKFLVgGVnAh3H-LQn02TH
        3. DBLOHXQEifqyXvGREFFyfPE0UuUWvAkEuPmztHmIL4tA
        4. DJdW_ODO0R3-HSjQzpxns3q0ZOk2pKzqDVrTjw3EK2BB
        5. DDqfjMS1optqaniJdD4s5iu_uUt4owNx9On9ASSbuYmv
        6. DN1xR4mMnf_xSnDW9d3brPyjccJNU_qIMOMK_lOobQ25 
        7. DDr8A0qhGxHKoKJwkHGzk6F8JFy5EQA--KDv-_AqPMpq 

```

At this point the QVI Group Multisig AID has been created and you may leave the video call.


## Join Multisig Group
If you were not elected to be the Lead for the creation of your QVI Group Multisig AID you will wait until the lead has
configured the AID and then use the `multisig-join.sh` script to accept the KERI Peer-to-Peer message the lead generated
and sent you when they created the AID inception event.  Assuming the configuration outlined in the "Configure Group Multisig"
section above and the member of the group named "Christoph Schneider" was joining the group, the output would look as follows:

```bash
$ ./scripts/multisig-join.sh
Waiting for group multisig events...

Group Multisig Inception proposed:

Participants:
+-------+---------------------+----------------------------------------------------------+
| Local | Name                |                     AID                      | Threshold |
+-------+---------------------+----------------------------------------------------------+
|       | John Doe            | ELZyCjnSL2Haors35LKM19T4qWT4K8Gfz1FPDD9oJN33 |    1/2    |
|   *   | Christoph Schneider | EJ97lUuRH3xz0OMKhdMAU6V2TcSF9X6m1CKyIbIUcRxp |    1/2    |
|       | Karla McKenna       | EJ97lUuRH3xz0OMKhdMAU6V2TcSF9X6m1CKyIbIUcRxp |    1/5    |
|       | Tim Sterker         | EJ97lUuRH3xz0OMKhdMAU6V2TcSF9X6m1CKyIbIUcRxp |    1/5    |
|       | Ines Gensinger      | EJ97lUuRH3xz0OMKhdMAU6V2TcSF9X6m1CKyIbIUcRxp |    1/5    |
|       | Kevin Griffin       | EJ97lUuRH3xz0OMKhdMAU6V2TcSF9X6m1CKyIbIUcRxp |    1/5    |
|       | Stephan Wolf        | EJ97lUuRH3xz0OMKhdMAU6V2TcSF9X6m1CKyIbIUcRxp |    1/5    |
+-------+---------------------+----------------------------------------------------------+

Configuration:
+---------------------+----------------------------------------------------------------+
| Name                |                           Value                                |
+---------------------+----------------------------------------------------------------+
| Signature Threshold |                             5                                  |
| Establishment Only  |                           False                                |
| Do Not Delegate     |                           False                                |
| Witness Threshold   |                             5                                  |
| Witnesses           |        BBilc4-L3tFUnfM_wJr4S4OJanAv_VmF_dJNN6vkf2Ha            |
|                     |        BLskRTInXnMxWaGqcpSyMgo0nYbalW99cGZESrz3zapM            |
|                     |        BIKKuvBwpmDVA4Ds-EpL5bt9OqPzWPja2LigFYZN2YfX            |
|                     |        BDjY4jRiYqKr_FPTt3MlK6tDUEUCAVL4pyI-t1RPwXP_            |
|                     |        BBpePuOUCrLGcu_L6cVKtVFk1KebGyL-9kROE9OmrWmj            |
+---------------------+----------------------------------------------------------------+

Join [Y|n]? Y

Enter alias for new AID: QVI External AID

```

At this point, if the configuration information all looks correct (as confirmed with the Lead while still on the video
call), you would enter Y at the first prompt to approve joining the group, then enter your local Alias for the group multisig
AID that you will be joining.  It is recommended that the aliases "QVI AID" and "QVI AID" be used for
the external and internal AIDs respectively.

After you accept the event you should leave this script running as you wait for all other participants to join the group and 
sign the inception event.  Upon completion, your output will update to the following:

```bash
$ ./scripts/multisig-join.sh
Waiting for group multisig events...

Group Multisig Inception proposed:

Participants:
+-------+---------------------+----------------------------------------------------------+
| Local | Name                |                     AID                      | Threshold |
+-------+---------------------+----------------------------------------------------------+
|       | John Doe            | ELZyCjnSL2Haors35LKM19T4qWT4K8Gfz1FPDD9oJN33 |    1/2    |
|   *   | Christoph Schneider | EJ97lUuRH3xz0OMKhdMAU6V2TcSF9X6m1CKyIbIUcRxp |    1/2    |
|       | Karla McKenna       | EJ97lUuRH3xz0OMKhdMAU6V2TcSF9X6m1CKyIbIUcRxp |    1/5    |
|       | Tim Sterker         | EJ97lUuRH3xz0OMKhdMAU6V2TcSF9X6m1CKyIbIUcRxp |    1/5    |
|       | Ines Gensinger      | EJ97lUuRH3xz0OMKhdMAU6V2TcSF9X6m1CKyIbIUcRxp |    1/5    |
|       | Kevin Griffin       | EJ97lUuRH3xz0OMKhdMAU6V2TcSF9X6m1CKyIbIUcRxp |    1/5    |
|       | Stephan Wolf        | EJ97lUuRH3xz0OMKhdMAU6V2TcSF9X6m1CKyIbIUcRxp |    1/5    |
+-------+---------------------+----------------------------------------------------------+

Configuration:
+---------------------+----------------------------------------------------------------+
| Name                |                           Value                                |
+---------------------+----------------------------------------------------------------+
| Signature Threshold |                             5                                  |
| Establishment Only  |                           False                                |
| Do Not Delegate     |                           False                                |
| Witness Threshold   |                             5                                  |
| Witnesses           |        BBilc4-L3tFUnfM_wJr4S4OJanAv_VmF_dJNN6vkf2Ha            |
|                     |        BLskRTInXnMxWaGqcpSyMgo0nYbalW99cGZESrz3zapM            |
|                     |        BIKKuvBwpmDVA4Ds-EpL5bt9OqPzWPja2LigFYZN2YfX            |
|                     |        BDjY4jRiYqKr_FPTt3MlK6tDUEUCAVL4pyI-t1RPwXP_            |
|                     |        BBpePuOUCrLGcu_L6cVKtVFk1KebGyL-9kROE9OmrWmj            |
+---------------------+----------------------------------------------------------------+

Join [Y|n]? Y

Enter alias for new AID: QVI AID
Sending multisig event to 1 other participants
Waiting for other signatures for 0...
Waiting for delegation approval...
Waiting for witness receipts for EOL2umo-DHgO9t22LR_iwmiR_cfsF531hcCh-zZ0p0gL

Alias:  QVI AID
Identifier: EDgkEWEfAnHTNmbHj4oJvOfYyFJC93lJ19WB2GOwFaNI
Seq No: 0
Delegated Identifier
    Delegator:  EK7j7BobKFpH9yki4kwyIUuT-yQANSntS8u1hlhFYFcg ✔ Anchored

Group Identifier
    Local Indentifier:  EHpJf8dVzrotWFmgWE9ouFunIqHqvmg3TZuFuLzp9sqf ✔ Fully Signed

Witnesses:
Count:          5
Receipts:       5
Threshold:      5

Public Keys:
        1. DFggExZfu3MGXrU1q6QdeaiBqeciMtLippy5htuKZV3G
        2. DHxmDwyt-TnQM0tNvyYmCogJKFLVgGVnAh3H-LQn02TH
        3. DBLOHXQEifqyXvGREFFyfPE0UuUWvAkEuPmztHmIL4tA
        4. DJdW_ODO0R3-HSjQzpxns3q0ZOk2pKzqDVrTjw3EK2BB
        5. DDqfjMS1optqaniJdD4s5iu_uUt4owNx9On9ASSbuYmv
        6. DN1xR4mMnf_xSnDW9d3brPyjccJNU_qIMOMK_lOobQ25 
        7. DDr8A0qhGxHKoKJwkHGzk6F8JFy5EQA--KDv-_AqPMpq 
```

At this point the QVI Group Multisig AID has been created and you may leave the video call.


## Next Steps
This document described the steps to create both the QVI AID and the QVI Internal AID.  Both AIDs will need to
perform periodic [key rotation](./rotating-group-aid.md) to ensure the safety of the AIDs.  However, these two AIDs have
different responsibilities after their inception. 

QVI AID is responsible for helping Qualified vLEI Issuers (QVIs)
[create their AIDs through delegation](./qar/approving-qvi-inception.md), 
[approve rotation requests from QVIs](./qar/approving-qvi-rotation.md) and the 
[issuance](./external-qar/issuing-qvi-credentials.md) and [revocation](./external-qar/revoking-qvi-credentials.md)
of the Qualified vLEI Issuer vLEI Credential to QVIs.

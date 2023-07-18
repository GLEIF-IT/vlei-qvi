# Rotating QVI Group Multisig AID

Once any new members to be added to a QVI Group Multisig AID have created their local AIDs
as described in [Getting Started](getting-started.md) the group multisig AID can be rotated using the following steps.

1. Join a Video Call with all other GARs.
2. Send your OOBI over video call to all new members.
3. Receive OOBIs from all new members over video call.
4. Send challenge message to all new members.
5. Receive challenge messages from all new members.
6. Configure and join the multisig group.
7. Wait for Delegation Approval from GLEIF External AID.


All existing members must complete the first 5 steps with only new members.  All new members must complete the first
five steps with all other members.  In addition, all new participants must perform the first 5 steps with all External
GARs (GLEIF Authorized Representatives).  The steps are described in detail below.  Once that has been completed, one member 
of the group must be selected as the Lead.  The Lead is responsible for running the Group Multisig Shell to generate 
the configuration file for the group multisig AID and initiate the rotation with that configuration file.  All other 
members will join the multisig group rotation once they receive the notification from the Lead.  The rest of this 
document describes the entire process.

## Join Video Call
The vLEI Ecosystem Governance Framework (vLEI EGF) mandates that all participants in the QVI AIDs must perform NIST-800-63-3 IAL-2 identity
assurance with all other participants in their group multisig.  In addition, once that is complete the members are required to join
a live video call with all other participants and present Out-of-band Introductions (OOBIs) and exchange signed challenge messages in the
same live session to satisfy the 2-factor identity authentication requirements.  The video sessions can be one-to-one video calls
between each participant-pair or one video call with all participants in the same session.  It is important during the video call to follow
the steps defined in the rest of this document to ensure proper compliance with the identity authentication requirements of the vLEI EGF.

## Connecting with other Participants and GARs
If there are any new participants, a verified connection must be established between those new participants and all existing
participants as well as between those new participants and the External GARs that will be approving the rotation event
as the delegator of the QVI AID.  The next section describes all operations as "between required participants".  For example,
existing participants do not need to resolve OOBIs or exchange challenge reponse messages with existing participants or with
External GARs.  It is this relationship of new participants with existing participants and External GARs that defines
"required".  *If there are no new participants in the group multisig for this AID, this process can be skipped and you
can jump to [Configure Group Multisig](#configure-group-multisig).*

## Send and Receive OOBIs
All required participants must generate an OOBI and paste their OOBI in the video call chat.  New participants must 
resolve all other OOBIs and all existing participants and External GARs must resolve the OOBIs of all new participants.
To generate an OOBI for your local AID, run the following script:

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
each of the other participants you have not previously established an alias with, you will need to resolve their OOBI 
that they have pasted into the video chat and assign them a local alias that you will use to refer to them in your 
local QAR environment.

For each required participant, copy their URL from the video chat and run the following command:

```bash
$ ./scripts/resolve-oobi.sh
```

First, this script will prompt you for URL of the OOBI you wish to resolve (ensure this is not your own URL):

```bash
Type or paste OOBI URL:
```

After you paste the copied OOBI the script will prompt you to enter an Alias for this OOBI.  This alias will be your
local "nickname" for the AID that is resolved from the OOBI.  It is local to you and not shared, so you should use a name 
that will uniquely identify the controller of the AID to you.  Once you type the alias and hit enter the system should 
indicate that the OOBI was resolve and show you the Alias and AID that was just created in your datastore.

```bash
Type or paste OOBI URL: http://20.3.144.86:5623/oobi/EHlegxGzgOsBLZQZJSUQW-vKwgeOo8YPcNMJIgTJO82Q/witness/BBD748wGFn9-1nfVEtfwd97wc-HCw0LRF2xeIujmqJOQ
Enter an Alias for the AID: John Doe

http://20.3.144.86:5623/oobi/EHlegxGzgOsBLZQZJSUQW-vKwgeOo8YPcNMJIgTJO82Q/witness/BBD748wGFn9-1nfVEtfwd97wc-HCw0LRF2xeIujmqJOQ resolved

Alias: John Doe
AID:   EHlegxGzgOsBLZQZJSUQW-vKwgeOo8YPcNMJIgTJO82Q
```

You must perform this step with each required participant in your group to retrieve their key event log for their AID and
associate an Alias with their AID.  When this is complete you'll have a local "contact" entry for each other participant and while
still on the save live video session you can move on to the next step to authenticate these contacts.

## Send and Receive Challenge Messages
In the same live session as the OOBI exchange, participants who have not previously challenged each other must 
challenge each other with a 12-word challenge phase that the other participant must sign and return.  This ensures 
that the other participants in the group are the sole controller of the private key of the AID resolved during the OOBI 
exchange protocol.

To challenge the other required participants in your group, you must generate a random challenge phrase using the
following command and paste it in a PRIVATE chat with the other participant.  The script will prompt you for the Alias
of the other participant you are challenging and display the 12-word phrase.  The script will then wait for the other
participant to use their system to sign the phrase (described below) and return it to you using a KERI peer-to-peer
protocol message.  Once you have recieved a valid signed challenge response containing the 12-word phrase from the other
participant.

#### Note:

---

* Each participant should generate a unique challenge phrase for each of the other participants being challenged*

* There should only be one member of the group running `generate-challenge.sh` at once.*

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

During this process you will also be challenged with a unique 12-word challenge that you must sign and return to the
originator or the challenge.  When you receive a 12-word challenge from another participant you must sign it and return
that signed response to the other participant using the following command:

```bash
$ ./scripts/respond-to-challenge.sh
```

This script is similar to the script used to resolve an OOBI earlier.  It will first prompt you to type or paste the 12-word
challenge, and then it will ask for the Alias of the AID who sent you challenge:

```bash
./scripts/respond-to-challenge.sh
Type or paste challenge sent to you: rice jewel into dance bean stadium west sister auto cupboard repair daughter
Enter the Alias who sent you the words: John Doe
Challenge phrase signed and sent
```

This will sign the 12-word challenge using the private key of your local AID and send the result back to the participant
who pasted it in chat for you.  The other participant will verbally confirm that they received your signed response, and
you can move on to challenging and responding with all other participants in the group.

When you are finished with this process with each other required participant in your group you can verify that you have 
authenticated contacts using the utility script `./scripts/contacts.sh` which will display the contact, their AID and the
authenticated state of that contact.

## Configure Group Multisig
As mentioned earlier in the document, once the OOBI and challenge response phase has been completed for every participant
pair in the group (everyone has authenticated contacts for everyone else), all existing members of the Multisig Group must run
the `./scripts/multisig-rotate.sh` script with the same parameters.  All new members of the group must run the 
`./scripts/multisig-join.sh` script to accept the invitation to the group and give it a name.

The existing members must (at a minimum) list the member AID of all participants in the rotation if adding or removing
any participants to the group using the `--smids` parameter (that can be repeated as many times as needed) to the rotate 
shell script.  For example:

```bash
$ ./scripts/multisig-rotate.sh --smids EKYLUMmNPZeEs77Zvclf0bSN5IN-mLfLpx2ySb-HDlk4 --smids EJccSRTfXYF6wrUVuenAIHzwcx3hJugeiJsEKmndi5q1 --smids ENkjt7khEI5edCMw5qugagbJw1QvGnQEtcewxb0FnU9U 
```

The follow is the list of all options that can be added to the rotate script with default values if omitted:

```
--smids - Signing members.  Defaults to exising signing members.
--rmids - Rotation members.  Defaults to signing members.
--isith - Signing threshold,  Defaults to existing group signing threshold.
--nsith - Rotation signing threshold  Defaults to signing threshold.
--toad = New witness threshold.  Defaults to existing witness threshold.
--witness-add - New witnesses to add to the group AID.  Defaults to [].
--witness-cut - Existing witnesses to remove from the group AID.  Defaults to [].
--witnesses - New set of witnesses to replace existing witnesses.  Defaults to None.
--data - arbitary JSON serializable data to anchor with this rotation event.  Defaults to None.
```

For a multisig group rotation specifying 3 members for both signing and rotation and a fractionally weighted threshold
of ["1/2", "1/2", "1/2] the following command would be used:

```bash
$ ./scripts/multisig-rotate.sh --smids EKYLUMmNPZeEs77Zvclf0bSN5IN-mLfLpx2ySb-HDlk4 --smids EJccSRTfXYF6wrUVuenAIHzwcx3hJugeiJsEKmndi5q1 --smids ENkjt7khEI5edCMw5qugagbJw1QvGnQEtcewxb0FnU9U --isith '["1/3", "1/3", "1/3"]' 
Enter the Alias for the Group Multisig AID: QVI AID
Rotated local member=EJccSRTfXYF6wrUVuenAIHzwcx3hJugeiJsEKmndi5q1, waiting for witness receipts
Sending local rotation event to 2 other participants
Sending rotation event to 2 other participants
Waiting for other signatures...

```

At this point you must leave this script running as it waits for the other participants in the group to join the group
multisig AID rotation (described in the next section for all other participants).

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

Request to add local AID 'multisig3' to multisig AID EC61gZ9lCKmHAS7U5ehUfEbGId5rcY0D7MirFZHDQcE2 in rotation to 1:

Participants:
+-------+-----------+----------------------------------------------+-----------+
| Local | Name      |                     AID                      | Threshold |
+-------+-----------+----------------------------------------------+-----------+
|   *   | multisig3 | ENkjt7khEI5edCMw5qugagbJw1QvGnQEtcewxb0FnU9U |    1/3    |
|       | multisig1 | EKYLUMmNPZeEs77Zvclf0bSN5IN-mLfLpx2ySb-HDlk4 |    1/3    |
|       | multisig2 | EJccSRTfXYF6wrUVuenAIHzwcx3hJugeiJsEKmndi5q1 |    1/3    |
+-------+-----------+----------------------------------------------+-----------+

Configuration:
+------+-------+
| Name | Value |
+------+-------+
+------+-------+
Join [Y|n]?
Please enter an alias for new AID:
Alias: mymultisig

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

Request to add local AID 'multisig3' to multisig AID EC61gZ9lCKmHAS7U5ehUfEbGId5rcY0D7MirFZHDQcE2 in rotation to 1:

Participants:
+-------+-----------+----------------------------------------------+-----------+
| Local | Name      |                     AID                      | Threshold |
+-------+-----------+----------------------------------------------+-----------+
|   *   | multisig3 | ENkjt7khEI5edCMw5qugagbJw1QvGnQEtcewxb0FnU9U |    1/3    |
|       | multisig1 | EKYLUMmNPZeEs77Zvclf0bSN5IN-mLfLpx2ySb-HDlk4 |    1/3    |
|       | multisig2 | EJccSRTfXYF6wrUVuenAIHzwcx3hJugeiJsEKmndi5q1 |    1/3    |
+-------+-----------+----------------------------------------------+-----------+

Configuration:
+------+-------+
| Name | Value |
+------+-------+
+------+-------+
Join [Y|n]?
Please enter an alias for new AID:
Alias: mymultisig
Sending local rotation event to 2 other participants
Sending rotation event to 2 other participants
Waiting for other signatures...
Waiting for fully signed witness receipts for 1
Witness receipts complete, EC61gZ9lCKmHAS7U5ehUfEbGId5rcY0D7MirFZHDQcE2 confirmed.

Alias:  mymultisig
Identifier: EC61gZ9lCKmHAS7U5ehUfEbGId5rcY0D7MirFZHDQcE2
Seq No: 1
Group Identifier
    Local Indentifier:  ENkjt7khEI5edCMw5qugagbJw1QvGnQEtcewxb0FnU9U ✔ Fully Signed

Witnesses:
Count:          3
Receipts:       3
Threshold:      3

Public Keys:
        1. DMH_DeVtqSMWCakrp5O1Ni4yRqDaz2fBCe2sEudjtwc1
        2. DHCHPHK79FVjwnQKvdnGsVLWw5BB3rVPygoWd86j3XtO
        3. DFwPrrwerRq3f_naaniZ1844G5IeaOY03nH97YkNKTo_

```

At this point the QVI Group Multisig AID has been rotated, and you may leave the video call.


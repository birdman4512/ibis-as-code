# RDPAuth Analysis - RDP Timeline

The queries on this page are focused on the analysis of the VR RDPAuth artefact.

## Remote Desktop Timeline

```
(not EventID: (4624 or 4634 or 4625 or 4647) or EventID: (4624 or 4634 or 4625 or 4647) and LogonType: 10) and UserName: [USER] and Computer: [DEST]
```

The search above, when applied to the RDPAuth index and sorted by timestamp ASC, will give you a sequential timeline of user sign in details. 

Replace

* [USER] with the target user account (Can use wildcards) - This can be removed if desired, ensure you remove the leading and

* [DEST] with the destination computer (Can use wildcards) - This can be removed if desired, ensure you remove the leading and

### How to read

The Event should appear in a the following order

#### logon

* Event ID: 1149 - Setup of RDP Session

* Event ID: 4624, LogonType: 10 - This is the logon event. This event is likely to occur twice. Once with a valid Logon GUID, once with an all 0 Logon GUID.

* Event ID: 21 - RDP Successful Authentication

* Event ID: 22 - RDP Shell Start

From here, the order will split based on the action

#### Disconnect and reconnect

* Event ID: 24 - Disconnected RDP Session

* Event ID: 1149 - Setup of RDP Session

* Event ID: 4624, LogonType: 10 - This is the logon event. This event is likely to occur twice. Once with a valid Logon GUID, once with an all 0 Logon GUID.

* Event ID: 25 - Reconnect RDP Session

* Event ID: 4634 - A session was logged off - Unsure of why.

#### Logoff

* Event ID: 23 - RDP Log off

* Event ID: 24 - Disconnect RDP Session

#### Signed off because another user signed in

* Event ID: 24 - Disconnect RDP Session for the original USER

* Event ID: 39 - With the same session ID as the Event ID 24 above

* See Logon series
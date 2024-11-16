# RDPAuth Analysis - RDP Timeline

## Goal

Produce an easy to read timeline of RDP activity that can be filtered on either username / machine name

## Index

Should be applied to `logstash-vr-rdpauth*` or `artifact_windows_eventlogs_rdpauth*` for VR Streaming

## View

The following colums in Discover can be helpful

* Time

* EventID 

* Description

* Computer

* SourceIP

* UserName

* LogonType

* Message

## Query

```
(not EventID: (4624 or 4634 or 4625 or 4647) or EventID: (4624 or 4634 or 4625 or 4647) and LogonType: 10) and UserName: [USER] and Computer: [DEST]
```

*Replace*

* [USER] with the target user account (Can use wildcards) - This can be removed if desired, ensure you remove the leading and

* [DEST] with the destination computer (Can use wildcards) - This can be removed if desired, ensure you remove the leading and

## How to read

The Event should appear in a the following order

### logon

* Event ID: 1149 - Setup of RDP Session

* Event ID: 4624, LogonType: 10 - This is the logon event. This event is likely to occur twice. Once with a valid Logon GUID, once with an all 0 Logon GUID.

* Event ID: 21 - RDP Successful Authentication

* Event ID: 22 - RDP Shell Start

From here, the order will split based on the action

### Disconnect and reconnect

* Event ID: 24 - Disconnected RDP Session

* Event ID: 1149 - Setup of RDP Session

* Event ID: 4624, LogonType: 10 - This is the logon event. This event is likely to occur twice. Once with a valid Logon GUID, once with an all 0 Logon GUID.

* Event ID: 25 - Reconnect RDP Session

* Event ID: 4634 - A session was logged off - Unsure of why.

### Logoff

* Event ID: 23 - RDP Log off

* Event ID: 24 - Disconnect RDP Session

### Signed off because another user signed in

* Event ID: 24 - Disconnect RDP Session for the original USER

* Event ID: 39 - With the same session ID as the Event ID 24 above

* See Logon series
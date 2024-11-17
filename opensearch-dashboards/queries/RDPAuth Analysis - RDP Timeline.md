# RDPAuth Analysis - RDP Timeline

## Goal

Produce an easy to read timeline of RDP activity that can be filtered on either username / machine name to understand how users (both legitimate and illegitimate) move around a network. 

## Query

```
(not EventID: (4624 or 4634 or 4625 or 4647) or EventID: (4624 or 4634 or 4625 or 4647) and LogonType: 10) and UserName: [USER] and Computer: [DEST]
```

*Replace*

* [USER] with the target user account (Can use wildcards) - This can be removed if desired, ensure you remove the leading and
* [DEST] with the destination computer (Can use wildcards) - This can be removed if desired, ensure you remove the leading and

or remove both for all users (This makes it more difficult to read)

## Index

Should be applied to `logstash-vr-rdpauth*` for offline collection or `artifact_windows_eventlogs_rdpauth*` for VR Streaming

## View

The following colums in Discover can be helpful

* Time - The time that the event took place
* EventID - The event ID to help understand the action that took place (See How to read)
* Description - A description of the event ID (See How to read)
* Computer - The computer that the activity took place on
* SourceIP - The source of the connection
* UserName - The username used.
* LogonType - The logon type (Generally type 10 which is RDP)
* Message - The message, stored within the message is a Session ID which can be used to track a session across events.

## How to read

The Event should appear in a the following order which align to the various steps in establishing and using a remote desktop session. Using combinations of the series below, you can understand 
1. When a user logs in
2. How they might use the session (i.e. they remain connected, or disconnect and reconnect)
3. The duration of the sessions. (Both total session duration, and connected duration)

### Logon

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

## References / Further Reading

* 
# Detection – Keychain Sync Capability Enabled

## Description

This detection identifies when a macOS device has the **capability to synchronize
Login Keychain data via iCloud Keychain**, based on runtime configuration and
service availability.

Unlike Apple ID login detection, which identifies a posture change,
this detection identifies **functional credential synchronization capability**.

---

## Why This Detection Exists

Credential risk on macOS increases significantly when **both** of the following are true:

- An Apple ID is present and authenticated
- Keychain synchronization services are available and running

This detection answers the question:

> “Is this device now capable of replicating stored credentials
> beyond the enterprise-managed perimeter?”

---

## Telemetry Signals Used

This detection relies on **correlated telemetry** across multiple layers.

### Account State Telemetry
- Apple ID configuration present on the device

### Process Telemetry
- `icloudaccountd` running
- `cloudd` running
- `CloudKeychainProxy` running 

### Unified Logging 
- `icloudaccountd` entitlement or service activation events
- `securityd` keychain evaluation events related to sync
- CloudKit readiness or initialization events

---

## Detection Logic 

Trigger this detection when:

1. Apple ID presence is confirmed

AND

2. One or more of the following conditions are met:
   - `CloudKeychainProxy` process is present
   - Both `icloudaccountd` and `cloudd` are running persistently
   - Unified logging indicates iCloud Keychain service activation

AND

- The device is corporate-managed
- The condition did not exist during approved onboarding
- No approved exception is recorded

---

## Severity

**High**

Rationale:
- Keychain sync capability represents a meaningful increase in credential exposure risk
- Sync availability enables replication, even if no credentials are confirmed
- This condition significantly reduces enterprise visibility

Severity may be escalated to **Critical** if correlated with:
- Active CloudKit sync activity
- Browser autofill usage on enterprise domains
- Absence of approved password manager tooling

---

## False Positive Considerations

Potential benign explanations include:
- Approved Apple ID usage with documented exception
- Temporary service activity during system setup
- Partial iCloud enablement without Keychain usage

Mitigation:
- Correlate with onboarding timelines
- Verify exception records
- Cross-check with CloudKit activity detection

---

## Recommended Response

This detection warrants **prompt review**, not automatic remediation.

Recommended actions:
1. Confirm whether Apple ID usage is approved
2. Validate that enterprise credentials are not stored in native Keychain
3. Ensure approved password manager tooling is present and active
4. Increase monitoring for:
   - Active iCloud sync
   - Browser autofill activity
   - `securityd` keychain access events

If the condition is unapproved:
- Require user acknowledgement of password policy
- Consider credential rotation based on risk assessment
- Document remediation or exception outcome

---

## Relationship to Policy

This detection supports policy enforcement related to:
- Prohibition of iCloud Keychain for enterprise credentials
- Governance of Apple ID usage on corporate macOS devices
- Risk-based handling of credential synchronization capability

---

## Audit & Reporting Value

This detection provides strong audit support by:
- Demonstrating monitoring of credential replication risk
- Showing escalation from configuration to functional capability
- Supporting explainable, layered security controls
- Aligning with macOS platform constraints

---

## Limitations

- Does not prove credentials are stored or synced
- Cannot identify which credentials might be eligible
- Relies on correlation rather than inspection

These limitations are expected.

---

## Summary

Keychain sync capability represents a **critical threshold** in macOS
credential risk.

This detection:
- Identifies when that threshold is crossed
- Enables timely governance and response
- Avoids unsupported enforcement techniques
- Forms a bridge between posture and activity detections


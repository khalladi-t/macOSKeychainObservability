# Detection – Active iCloud / Keychain Synchronization

## Description

This detection identifies **active iCloud synchronization activity** on an
enterprise managed macOS device that is capable of synchronizing Login
Keychain data.

While prior detections establish Apple ID presence and Keychain sync capability,
this detection focuses on **runtime execution** confirming that iCloud services
are actively performing synchronization operations.

---

## Why This Detection Exists

Credential risk on macOS follows a progression:

1. Apple ID present 
2. Keychain sync capability enabled 
3. **Active synchronization occurring**

---

## Telemetry Signals Used

This detection relies primarily on **CloudKit and process activity telemetry**,
with optional corroboration from other sources.

### Process Telemetry 
- `cloudd` running persistently
- `CloudKeychainProxy` running if present

### Unified Logging 
- CloudKit-related events emitted by `cloudd`
  - Sync initiation
  - Sync completion
  - Retry or failure loops

### Correlative Telemetry 
- Apple ID account-state telemetry
- Keychain sync capability detection
- `securityd` events consistent with keychain evaluation during sync windows

---

## Detection Logic

Trigger this detection when:

1. Keychain sync capability has been identified  
2. CloudKit (`cloudd`) emits events indicating active synchronization  
3. Synchronization occurs outside:
   - Initial device provisioning
   - Approved maintenance or exception windows

AND

- The device is corporate-managed
- No documented exception exists for iCloud sync usage

---

## Severity

**High**

Rationale:
- Active synchronization represents **execution of the risk pathway**
- Indicates movement of data across trust boundaries
- Confirms that prior posture and capability detections are materializing

Severity may be escalated to **Critical** if correlated with:
- Browser autofill usage on enterprise domains
- Keychain access events (`securityd`) near sync windows
- Absence of approved password manager tooling

---

## False Positive Considerations

Potential benign scenarios include:
- Sync of non-credential iCloud data 
- Approved Apple ID usage with scoped services
- Initial device configuration phases

Mitigation:
- Require correlation with keychain sync capability
- Apply onboarding and exception exclusions
- Review repeated or sustained sync activity patterns

---

## Recommended Response

This detection warrants **immediate review**.

Recommended actions:
1. Confirm whether Apple ID and iCloud sync usage is approved
2. Verify that enterprise credentials are managed exclusively via
   the approved password manager
3. Assess whether credential rotation is necessary
4. Engage the user for clarification if approval status is unclear
5. Document outcome 

---

## Relationship to Policy

This detection enforces policy guidance regarding:
- Prohibition of iCloud Keychain for enterprise credentials
- Control and governance of credential replication
- Elevated response requirements for active sync behavior

---

## Audit & Reporting Value

This detection strengthens audit posture by:
- Demonstrating monitoring beyond static configuration
- Showing detection of real-time data movement potential
- Supporting layered, risk-based security controls
- Aligning with platform-supported observability

---

## Limitations

- Cannot identify what data types are syncing
- Cannot confirm presence of credentials in sync payloads
- CloudKit supports many services beyond Keychain

These limitations are expected.
---

## Summary

Active iCloud synchronization represents the **highest-risk operational state**
for macOS Keychain governance.

This detection:
- Confirms execution, not just possibility
- Enables timely and proportionate response
- Completes the detection chain from posture to behavior
- Operates within supported Apple security boundaries

# Detection – Browser Autofill Usage on Enterprise Domains

## Description

This detection identifies **browser-based credential autofill or password
handling behavior** on corporate-managed macOS devices that may result in
enterprise credentials being stored in the macOS Login Keychain.

Browsers are the primary ingress point for credentials into the Login Keychain.
As such, browser autofill activity represents the **most direct signal of
potential enterprise credential storage** outside of approved password managers.

---

## Why This Detection Exists

Even when:
- An approved password manager is deployed
- Apple ID usage is monitored
- iCloud sync is governed

Enterprise credentials can still enter the Login Keychain if users:
- Accept browser “save password” prompts
- Use native autofill on enterprise applications
- Bypass or disable approved tooling

This detection answers:

> “Are credentials entering the OS-native credential store via browsers,
> contrary to enterprise policy?”

---

## Telemetry Signals Used

This detection relies on **browser configuration visibility and behavior
correlated with system telemetry**.

### Browser Signals

Depending on browser enforcement capabilities:

- Browser password manager enabled state
- Autofill feature usage indicators
- Password save or autofill events 
- Presence or absence of approved password manager extensions

Browsers of interest include:
- Safari
- Any Chromium based browser

---

### Unified Logging

- `securityd` events indicating Keychain access
- Timing correlation between browser activity and Keychain access
- Repeated access events tied to browser processes

---

### Contextual Signals

- Apple ID login detection
- Keychain sync capability detection
- Active iCloud sync detection

---

## Detection Logic 

Trigger this detection when:

1. Browser activity indicates credential autofill or password handling

AND

2. The activity targets:
   - Enterprise domains
   - Corporate authentication endpoints

AND

3. One or more of the following conditions exist:
   - Native browser password managers are enabled
   - Approved password manager tooling is missing or inactive
   - `securityd` events correlate tightly with browser activity

---

## Severity

**High**

Rationale:
- Browser autofill directly writes credentials into the Login Keychain
- Stored credentials become eligible for iCloud Keychain sync
- This represents a **direct policy deviation**, not just a posture change

Severity may be escalated to **Critical** if correlated with:
- Keychain sync capability enabled
- Active iCloud synchronization
- Repeated autofill behavior across enterprise apps

---

## False Positive Considerations

Potential benign scenarios include:
- Autofill of non-authentication form fields
- Approved testing or exception use cases
- Residual autofill behavior during policy rollout

Mitigation:
- Correlate with password manager enforcement state
- Exclude onboarding and migration windows
- Focus on repeated or sustained behavior

---

## Recommended Response

This detection warrants **prompt remediation-focused review**.

Recommended actions:
1. Notify the user of approved password manager requirements
2. Confirm browser configuration and enforcement state
3. Disable or remediate built-in password manager settings
4. Require migration of any stored credentials into the approved tool
5. Consider credential rotation if enterprise credentials may have been stored

---

## Relationship to Policy

This detection enforces policy guidance regarding:
- Mandatory use of approved password managers
- Prohibition of browser-native credential storage
- Protection against unmanaged credential replication

---

## Audit & Reporting Value

This detection provides high audit value by:
- Demonstrating enforcement of password management policy
- Showing control at the primary credential ingress point
- Supporting credential hygiene initiatives
- Enabling explainable, reviewable response actions

---

## Limitations

- Safari provides limited direct observability
- Some browser events may only be inferred via correlation
- Enforcement and visibility vary by browser and OS version

---

## Summary

Browser autofill represents the **most direct path** for enterprise credentials
to enter the macOS Login Keychain.

This detection:
- Identifies real credential ingress behavior
- Complements Apple ID and sync detections
- Enables targeted remediation
- Operates within supported macOS security boundaries

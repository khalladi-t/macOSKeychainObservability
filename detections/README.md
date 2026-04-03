# Detections

## Purpose

The detections layer translates macOS Keychain and iCloud telemetry into
**actionable security signals**.

While macOS does not allow inspection of Keychain contents, it provides
observable system behavior that can be correlated to identify:

- Risky configurations
- Policy deviations
- Credential exposure pathways
- Changes in security posture

Detections prioritize **accuracy, explainability, and defensibility**
over aggressive or speculative alerting.

---

## Detection Philosophy

This repository follows a detection‑first design, not a prevention‑only model.

Guiding principles:

- **Capability over content**
  - Detect *what is possible*, not what cannot be inspected

- **Correlation over single events**
  - No detection relies on a single log entry

- **Low false positives**
  - Detections should be understandable and reviewable

- **Platform‑aligned**
  - No unsupported enforcement or assumptions

---

## Telemetry → Detection Model

Detections are built by correlating telemetry from multiple layers:

| Telemetry Layer | Purpose |
|---------------|--------|
| Account State | Apple ID / iCloud capability |
| Process State | Runtime service availability |
| Unified Logging | Event‑level activity |
| Browser Signals | Credential entry points |

No detection in this repository is designed to operate in isolation.

---

## Detection Categories

###  Configuration & Posture Detections

Detect changes in system state that increase credential risk.

Examples:
- Apple ID added to a corporate macOS device
- iCloud services enabled post‑onboarding
- Keychain sync capability becoming available

These detections answer:
> “Is the device a higher‑risk posture?”

---

###  Activity Detections

Detect events that indicate credential handling behavior.

Examples:
- Keychain access events correlated with browser activity
- Credential access following Apple ID enablement
- Unexpected Keychain activity outside baseline windows

These detections answer:
> “Is credential‑related activity occurring now?”

---

###  Policy Deviation Detections

Detect behavior that conflicts with defined enterprise policy.

Examples:
- Browser autofill on enterprise domains
- Absence or tampering of approved password manager tooling
- iCloud sync activity without documented exception

These detections answer:
> “Is observed behavior aligned with policy?”

---

## Detection Structure

Each detection document follows a consistent structure:

- **Description**
- **Telemetry Signals Used**
- **Detection Logic**
- **Severity**
- **False Positive Considerations**
- **Recommended Response**

This ensures detections are:
- Reviewable
- Auditable
- Easy to operationalize

---

## Severity Model

| Severity | Meaning |
|--------|--------|
| Low | Informational or expected behavior |
| Medium | Risk posture change |
| High | Likely policy deviation or exposure risk |
| Critical | Active risk requiring immediate response |

Severity may increase when multiple detections correlate.

---

## Intended Outcomes

Detections enable:

- User education
- Credential rotation
- Exception handling
- Incident response
- Audit evidence

---

## Relationship to Policy

Detections are explicitly mapped to policy guidance.

Policy defines:
- What is allowed
- What is discouraged
- What requires review

Detections provide visibility into:
- When policy *may* have been violated
- When risk posture changes

---

## Summary

macOS Keychain security requires detection‑driven governance.

This detections layer:
- Converts telemetry into signal
- Aligns with Apple’s security model
- Supports enforcement where possible
- Enables response where prevention is not

> Detection is not a compromise.

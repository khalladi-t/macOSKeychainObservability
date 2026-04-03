# MITRE ATT&CK Mapping – macOS Keychain Observability

## Purpose

This document maps detections in this repository to relevant
MITRE ATT&CK tactics and techniques.

This repo **does not assume malware presence**.
Mappings reflect **potential attacker abuse paths**, not confirmed adversary activity.

---

## Scope of ATT&CK Mapping

This mapping applies to:

- macOS credential handling
- Operating system–native credential stores
- Browser-based credential storage
- Cloud-based credential synchronization

It does **not** cover:
- Lateral movement
- Command and control
- Malware execution chains

---

## High-Level ATT&CK Tactics Covered

| Tactic ID | Tactic Name |
|---------|-------------|
| TA0006 | Credential Access |
| TA0010 | Exfiltration |
| TA0005 | Defense Evasion |

---

## Technique Mapping Summary

### TA0006 – Credential Access

These detections relate to techniques where credentials may be obtained
from operating system or browser-managed stores.

| Technique | Description | Relevant Detections |
|---------|-------------|---------------------|
| Credentials from Password Stores | Abuse of OS-native credential storage | `keychain-sync-capability`, `active-icloud-sync` |
| Credentials from Web Browsers | Browser-based password storage and autofill | `browser-autofill` |
| Credentials Stored in Cloud Services | Sync of credentials to third-party cloud | `active-icloud-sync` |

---

### TA0010 – Exfiltration

These detections relate to **movement of sensitive data across trust boundaries**,
including cloud services.

| Technique | Description | Relevant Detections |
|---------|-------------|---------------------|
| Exfiltration Over Web Services | Data synced via legitimate cloud services | `active-icloud-sync` |

> Note: iCloud Keychain sync represents a legitimate service that can be abused
> for unintended credential propagation. This mapping reflects **risk capability**, not intent.

---

### TA0005 – Defense Evasion

These detections relate to techniques where legitimate tools or services
are used to bypass or weaken enterprise controls.

| Technique | Description | Relevant Detections |
|---------|-------------|---------------------|
| Living Off the Land | Abuse of built-in OS features | `browser-autofill`, `apple-id-login` |
| Trusted Service Abuse | Use of trusted cloud and identity services | `keychain-sync-capability`, `active-icloud-sync` |

---

## Detection-Level Mapping

### Apple ID Login `apple-id-login`

**Tactics**
- Credential Access (TA0006)
- Defense Evasion (TA0005)

**Rationale**
- Enables credential synchronization via trusted cloud identity
- Expands attacker opportunity surface if credentials are later compromised

---

### Keychain Sync Capability `keychain-sync-capability`

**Tactics**
- Credential Access (TA0006)
- Exfiltration (TA0010)

**Rationale**
- Establishes functional ability to replicate credentials outside managed perimeter
- No credential theft assumed — capability-based risk

---

### Active iCloud Sync `active-icloud-sync`

**Tactics**
- Credential Access (TA0006)
- Exfiltration (TA0010)

**Rationale**
- Confirms active cloud data movement
- Represents execution of credential replication pathway

---

### Browser Autofill `browser-autofill`

**Tactics**
- Credential Access (TA0006)
- Defense Evasion (TA0005)

**Rationale**
- Browser-native credential storage bypasses sanctioned password managers
- Direct ingress into OS-level credential stores

---

## Important Clarifications

- ATT&CK mapping **does not imply compromise**
- These detections identify **conditions that align with known attack techniques**
- Mapping is used for:
  - Threat modeling
  - Coverage analysis
  - Detection engineering maturity

---

## How to Use This Mapping

- Identify ATT&CK coverage gaps
- Correlate with other ATT&CK-aligned detections
- Explain detection value to auditors or stakeholders
- Align macOS security posture with enterprise threat frameworks

---

## Summary

macOS Keychain observability aligns naturally with MITRE ATT&CK because:

- Credential storage is a common attack surface
- Cloud sync represents a legitimate exfiltration pathway
- Browser credential handling mirrors real-world attacker techniques

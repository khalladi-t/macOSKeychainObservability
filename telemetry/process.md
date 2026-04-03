# Keychain & iCloud Process Telemetry

## Purpose

This document describes macOS processes associated with Keychain access,
Apple ID state, and iCloud synchronization that can be used as **runtime
telemetry signals** for credential risk assessment.

Unlike account-state telemetry (which detects configuration),
process telemetry detects **active capability and behavior**.

---

## Why Process Telemetry Matters

macOS Keychain contents are not observable, but the **services that mediate
access and synchronization are**.

Process telemetry allows defenders to answer:

- Is iCloud functionality currently active?
- Is Keychain synchronization possible at this moment?
- Did system behavior change after onboarding?
- Are credential-related services running unexpectedly?

These signals are especially useful when correlated with:
- Apple ID state
- Browser behavior
- Policy enforcement status

---

## Core Processes of Interest

### 1. `securityd`

**Role**
- Core Keychain Services daemon
- Enforces access controls
- Handles encryption and authorization

**Behavior**
- Always present on macOS
- Activity spikes correlate with credential access
- Mediates all Keychain API calls

**Security Relevance**
- Indicates Keychain interaction events
- Cannot be disabled or replaced
- Serves as a foundational signal for unified logging correlation

**Notes**
- Presence alone is not suspicious
- Used primarily for log-based telemetry, not runtime presence checks

---

### 2. `icloudaccountd`

**Role**
- Manages Apple ID authentication state
- Brokers access to iCloud services

**Behavior**
- Runs when an Apple ID is configured
- Persists during active iCloud usage
- Relaunched during account changes

**Security Relevance**
- Strong indicator of Apple ID activation
- Required for iCloud Keychain availability
- High-signal process for credential sync capability

**Detection Value**
✅ Running → iCloud services enabled  
❌ Not running → iCloud services likely inactive  

---

### 3. `cloudd`

**Role**
- CloudKit synchronization agent
- Handles data sync between device and iCloud

**Behavior**
- Long-running background process
- Activity increases during sync operations
- Relaunches on configuration changes

**Security Relevance**
- Indicates active iCloud data synchronization
- Supports Keychain sync operations indirectly
- Useful for detecting runtime state vs static config

**Detection Value**
✅ Running persistently → iCloud sync active  
⚠️ Frequent restarts → configuration changes  

---

### 4. `CloudKeychainProxy`

**Role**
- Coordinates Keychain-specific iCloud sync
- Interfaces between Keychain Services and CloudKit

**Behavior**
- Runs only when iCloud Keychain capabilities are enabled
- May not be present on all systems

**Security Relevance**
- High-confidence indicator of Keychain sync capability
- Strong correlation with credential replication risk

**Detection Value**
✅ Running → Keychain sync path available  

---

## Interpreting Process Telemetry

### Valid Combinations

| Apple ID | Processes | Interpretation |
|-------|-----------|----------------|
| ❌ | None running | Low risk, no sync capability |
| ✅ | `icloudaccountd` only | Apple ID present, limited activity |
| ✅ | `icloudaccountd` + `cloudd` | iCloud services active |
| ✅ | All above + `CloudKeychainProxy` | Keychain sync highly likely |

---

## What Process Telemetry Does *Not* Show

- Which credentials are stored
- Whether Keychain entries exist
- What data is being synchronized
- Whether enterprise credentials were used

Process telemetry measures **capability and activity**, not content.

---

## Security Relevance

Process telemetry provides:

- Runtime confirmation of iCloud capability
- Evidence of configuration drift
- Correlation points for unified logging
- Support for detection and response decisions

It is most effective when combined with:
- Apple ID account-state telemetry
- Browser enforcement visibility
- Approved password manager status

---

## Limitations

- Processes may run briefly during system activity
- Presence alone does not confirm credential storage
- Must be correlated with other telemetry for confidence

These limitations are expected and acceptable.

---

## Summary

Keychain and iCloud-related process telemetry enables defenders to:

- Observe runtime credential sync capability
- Detect high-risk operational states
- Differentiate configuration from active behavior
- Build higher-confidence detections

This telemetry is a critical second layer after account-state detection
and before event-level unified logging.

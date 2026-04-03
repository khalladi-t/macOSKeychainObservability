# Apple ID & iCloud Account State Telemetry

## Purpose

This document describes how to detect Apple ID and iCloud account state
on macOS devices in order to assess credential synchronization risk.

Apple ID sign-in is a **prerequisite condition** for iCloud Keychain sync.
Detecting this state provides a high-confidence signal of potential
credential replication.

---

## Why This Matters

Without an Apple ID:
- iCloud Keychain cannot sync credentials off-device
- Login Keychain remains local-only

With an Apple ID:
- Eligible credentials may sync to personal devices
- Enterprise visibility and control is reduced

Apple ID state therefore represents a **binary risk transition**.

---

## Observable Signals

### 1. Apple ID Configuration Artifacts

The presence of user-level Apple ID configuration files indicates
that an Apple ID has been added to the macOS user profile.

Common locations include:

- `~/Library/Preferences/MobileMeAccounts.plist`
- `~/Library/Application Support/iCloud/Accounts/`

Signal interpretation:
- ✅ File present → Apple ID configured
- ❌ File absent → Apple ID not configured

---

### 2. iCloud Service Processes

The following user-context processes are associated with Apple ID
and iCloud services:

- `icloudaccountd`
- `cloudd`
- `CloudKeychainProxy`

Signal interpretation:
- Process running persistently → iCloud services active
- Process absent → iCloud services inactive

---

### 3. State Transitions

A change from:
- No Apple ID → Apple ID present  
or
- iCloud processes absent → running  

should be treated as a **security-relevant configuration change**.

---

## What This Telemetry Does *Not* Show

- Whether credentials actually exist in Keychain
- What data is being synchronized
- Which credentials are stored

This telemetry detects **capability**, not content.

---

## Security Relevance

Apple ID state is one of the strongest indicators of:
- Potential credential replication
- Reduced audit visibility
- Policy deviation risk

As such, Apple ID enablement should:
- Generate alerts
- Trigger user education
- Inform exception handling
- Be logged for audit purposes

---

## Limitations

- Presence does not guarantee credentials were stored
- Absence does not prove credentials were never stored
- State must be correlated with browser and tool telemetry

These limitations are acceptable and expected.

---

## Summary

Apple ID account state is:
- Observable
- Stable
- Low-noise
- Highly relevant

It is the recommended **starting point** for macOS Keychain observability.

# Unified Logging – icloudaccountd

## Purpose

This document defines how to use macOS Unified Logging to observe
Apple ID lifecycle events and iCloud service activity through the
`icloudaccountd` process.

`icloudaccountd` is responsible for Apple ID authentication state and
service entitlement, making it a **primary indicator of iCloud
capability changes**, including those that enable iCloud Keychain.

---

## Why `icloudaccountd` Matters

`icloudaccountd` manages:

- Apple ID sign-in and sign-out
- Account authentication refresh
- iCloud service eligibility
- Activation of downstream sync services

Without `icloudaccountd`:
- iCloud services cannot function
- iCloud Keychain sync is not available

As a result, `icloudaccountd` unified logging provides **high-confidence
telemetry** for detecting security-relevant configuration changes.

---

## Relevant Log Subsystems

High-value log subsystems include:

- `com.apple.icloud`
- `com.apple.accounts`
- `com.apple.appleaccount`
- `com.apple.security`

Not all events are relevant; filtering is required.

---

## Log Collection (Manual Example)

Focused log streaming for Apple ID and iCloud activity:

```bash
log stream \ --predicate 'process == "icloudaccountd"' \ --style syslog

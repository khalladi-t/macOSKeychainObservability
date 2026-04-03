# Unified Logging – CloudKit

## Purpose

This document defines how to observe iCloud synchronization activity on macOS
using Unified Logging related to CloudKit, primarily through the `cloudd` process.

CloudKit serves as the underlying transport for many iCloud services,
including iCloud Keychain synchronization. While CloudKit does not expose
content-level visibility, it provides strong **behavioral telemetry**
confirming when sync activity occurs.

---

## Why CloudKit Matters

CloudKit represents the **final execution layer** of iCloud Keychain risk.

- Apple ID presence enables capability
- `icloudaccountd` authorizes services
- `CloudKeychainProxy` coordinates Keychain sync
- **CloudKit actually moves data**

If CloudKit is inactive, credential replication is unlikely.
If CloudKit is active, replication is possible or occurring.

This makes CloudKit telemetry critical for validating **real-world impact**.

---

## Primary Process

### `cloudd`

**Role**
- CloudKit synchronization daemon
- Handles data transfer between local device and iCloud
- Supports multiple iCloud-backed services, including Keychain

**Behavior**
- Runs in user context
- Activates during sync windows
- Persists while iCloud services are enabled
- Scales activity based on data volume and connectivity

---

## Relevant Log Subsystems

High-value log subsystems include:

- `com.apple.CloudKit`
- `com.apple.cloudd`
- `com.apple.icloud`
- `com.apple.cloudkit.sync`

These subsystems emit events related to:
- Sync scheduling
- Sync execution
- Transport state
- Error conditions

---

## Log Collection (Manual Example)

Focused CloudKit telemetry can be observed using:

```bash
log stream \ --predicate 'process == "cloudd"' \ --style syslog

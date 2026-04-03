# Unified Logging – securityd

## Purpose

This document defines how to use macOS Unified Logging to observe
Keychain-related activity mediated by the `securityd` daemon.

While Keychain contents are intentionally opaque, `securityd` emits
high-value log events that indicate **credential access behavior**,
authorization decisions, and Keychain API usage.

This telemetry enables event-level detection without violating
macOS security boundaries.

---

## Why `securityd` Matters

`securityd` is the core Keychain Services daemon on macOS.

All Keychain operations—whether initiated by:
- Safari
- Browsers
- Applications 
- System services

…are mediated through `securityd`.

As a result:
- You cannot bypass it
- You cannot disable it
- You **can observe its behavior**

This makes `securityd` the **most authoritative telemetry source**
for Keychain interaction events.

---

## Relevant Log Subsystems

Key subsystems and categories include:

- `com.apple.security`
- `com.apple.securityd`
- `com.apple.keychain`
- `com.apple.KeychainCircle`

Not all subsystems emit high-signal events; filtering is required.

---

## Log Collection (Manual Example)

The following example demonstrates focused log collection
for Keychain-related activity:

```bash
log stream \
  --predicate 'process == "securityd"' \
  --style syslog

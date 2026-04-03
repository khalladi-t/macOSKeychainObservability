# Policy Enforcement

## Purpose

This document defines enterprise policy guidance for managing credential storage
on macOS devices in environments where full Keychain disablement is not supported.

It aligns:
- macOS platform constraints
- Security best practices
- Enterprise tooling
- Detection and governance controls

This policy is designed to be **technically enforceable**.

---

## Policy Objectives

The objectives of this policy are to:

- Protect enterprise credentials from uncontrolled storage or replication
- Enforce use of an approved password manager
- Reduce risk from personal credential sync services
- Maintain visibility and auditability
- Remain complaint with macOS security boundaries

---

## Approved Credential Storage (EXAMPLE)

### ✅ Approved
- **Keeper Security**
  - Keeper Desktop Application
  - Keeper Browser Extensions
- Credentials stored and managed by Keeper vaults

### ❌ Not Approved for Enterprise Credentials
- macOS Login Keychain
- iCloud Keychain synchronization
- Browser-built-in password managers
- Personal password managers
- Plain-text storage

---

## Browser Controls (Primary Enforcement Layer)

Browser enforcement is the **primary technical control**.

### Enforcement Actions
- Disable built-in browser password managers
- Prevent browser credential synchronization
- Force installation of desired app browser extension(s)
- Block installation of competing password manager extension(s)

### Rationale

Browsers are the most common entry point for credentials into the macOS Login Keychain.
Preventing browser-based storage significantly reduces credential exposure risk.

---

## Apple ID & iCloud Usage

### Policy Position
- Corporate credentials **must not** be synchronized via personal Apple IDs
- Apple ID usage on corporate macOS devices is:
  - Either restricted
  - Or monitored with documented exception approval

### Enforcement Reality
macOS does not provide a supported mechanism to fully disable Apple ID usage.
Therefore:
- Apple ID presence is treated as a **risk posture signal**
- iCloud service activation is monitored
- Exceptions are governed, not ignored

---

## Keychain Usage Policy

### Allowed Usage
- System-required Keychain functionality
- Non-enterprise personal credentials (where permitted by policy)

### Prohibited Usage
- Storing enterprise credentials in:
  - iCloud Keychain
  - Browser autofill backed by Login Keychain
  - Unapproved password managers

### Important Clarification
macOS Keychain cannot be fully disabled or replaced.
This policy governs **how enterprise credentials are handled**, not the existence of Keychain itself.

---

## Detection & Monitoring

The following conditions are monitored as security-relevant events:

- Apple ID sign-in on corporate macOS devices
- iCloud service activation
- Browser autofill usage on enterprise domains
- Absence or tampering of Keeper tooling
- Credential behavior inconsistent with policy

Detection enables:
- User education
- Credential rotation
- Security review
- Exception handling

---

## User Responsibilities

Users are expected to:
- Use approved PW manager for all enterprise credentials
- Avoid browser or OS-level password saving prompts
- Report unintended credential storage
- Acknowledge password management policy

This policy assumes good-faith user behavior supported by guardrails.

---

## Exceptions

### Exception Criteria
Exceptions may be granted for:
- Documented business requirements
- Verified technical incompatibilities
- Temporary transitional use cases

### Exception Handling
- All exceptions must be documented
- Exceptions are time-bound
- Exceptions are reviewed periodically
- Detection remains in place during exceptions

---

## Incident Response

Potential policy violations may trigger:

- Credential rotation
- User education
- Security review
- Temporary access restrictions
- Escalation if repeated or high-risk

This policy emphasizes response and remediation over punishment.

---

## Compliance & Audit Position

This policy:
- Aligns with macOS platform security design
- Uses supported controls
- Employs detection where prevention is not feasible
- Is auditable and defensible

Claims of full Keychain disablement or absolute prevention are **intentionally avoided**.

---

## Summary

macOS credential governance requires balancing technical constraints with security outcomes.

This policy:
- Enforces what can be enforced
- Detects what cannot be blocked
- Governs behavior transparently
- Prioritizes credential protection without breaking the platform

> The goal is secure usage, not total restriction.
``

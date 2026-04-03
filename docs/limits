# Limitations & Design Constraints

## Purpose

This document explicitly defines the technical and architectural limitations
of macOS Keychain governance in enterprise environments.

It explains:
- What cannot be prevented
- What cannot be observed
- Why those constraints exist
- How risk is managed despite them

These limitations are **intentional properties of the macOS security model**,
not implementation gaps.

---

## Guiding Principle

Apple treats credential storage and synchronization as **core operating system security services**.
As a result:

> Apple permits application‑level control of credential storage through Keychain APIs, but explicitly denies platform‑level administrative authority to centrally disable, replace, or monopolize credential storage on macOS.

This project works **with** those boundaries, not against them.
Examples of app-level control is GCM: https://github.com/git-ecosystem/git-credential-manager



> This allows:

| GCM Capability                   | Scope                            |
|------------------------------|----------------------------------    |
| Chooses whether Git uses Keychain               | ✅ App-level      |
| Controls its own credential items   | ✅ App-level                  |
| Reads back items it created         | ✅ App-level                  |
| Prevents Safari from storing passwords         | ❌ Platform-level  |
| Prevents other apps from using Keychain  | ❌ Platform-level        |
| Overrides OS autofill behavior    | ❌ Platform-level               |
| Blocks iCloud Keychain sync globally    | ❌ Platform-level         |

---

## 1. macOS Keychain Cannot Be Disabled or Replaced

### Limitation

- The Login Keychain cannot be removed
- The Keychain subsystem cannot be uninstalled
- Credential storage cannot be redirected exclusively to a third-party password manager

### Reason

Keychain Services are enforced by:
- System Integrity Protection (SIP)
- Secure Enclave
- Apple-signed entitlements

Allowing full administrative override would weaken:
- Malware resistance
- User privacy guarantees
- Hardware-backed trust assumptions

### Security Implication

- Enterprise password managers cannot achieve **exclusive control**
- OS-native credential storage must be treated as persistent

---

## 2. iCloud Keychain Cannot Be Reliably “Hard Disabled”

### Limitation

- There is no universal, permanent kill-switch for iCloud Keychain
- Disabling sync ≠ eliminating local credential storage
- Apple ID enforcement is conditional and context-dependent

### Reason

iCloud Keychain is:
- A synchronization service, not a separate vault
- Tightly integrated with Apple ID identity
- Protected by end-to-end encryption and hardware trust

Apple prioritizes:
- User autonomy
- Privacy
- Device continuity

### Security Implication

- Risk is introduced **when sync capability exists**
- Detection of Apple ID state is more reliable than attempted prevention

---

## 3. Keychain Contents Are Not Inspectable

### Limitation

- Keychain entries cannot be enumerated or audited
- Stored credentials cannot be inspected
- Password values are never accessible

### Reason

- Keychain contents are encrypted and access-controlled by `securityd`
- Inspection APIs are intentionally unavailable
- This prevents both malware and administrators from abusing access

### Security Implication

- Security must focus on **behavior**, not content
- Telemetry is derived from:
  - Process activity
  - Account state
  - User interactions

---

## 4. Secure Enclave Is a Hard Boundary

### Limitation

- Hardware-backed keys are completely opaque
- Secure Enclave material cannot be enumerated or managed
- Administrative privilege does not grant access

### Reason

Secure Enclave is designed to:
- Prevent credential extraction
- Resist physical attacks
- Eliminate software-level compromise paths

### Security Implication

- These keys are out of scope by design
- They are not passwords and pose no enterprise reuse risk

---

## 5. Browser Autofill Cannot Be Universally Disabled on macOS

### Limitation

- Safari integrates natively with Keychain Services
- Safari controls are less granular than Chromium-based browsers
- Full prevention may conflict with usability or business requirements

### Reason

Apple treats Safari autofill as:
- A first-class security feature
- Safer than form-based password reuse
- Core to the platform experience

### Security Implication

- Browser controls are applied where supported
- Safari-specific risk may require policy and monitoring
- Enforcement focuses on supported surfaces, not perfection

---

## 6. Enforcement Alone Is Insufficient

### Limitation

- Technical controls cannot fully prevent all credential storage paths
- Users retain autonomy over Apple ID sign-in
- Some behavior cannot be blocked without unacceptable impact

### Reason

macOS enterprise security is designed around:
- Guardrails, not total restriction
- User education and consent
- Detection and response

### Security Implication

> Detection replaces prevention where prevention is not sustainable.

This is an accepted, supported security model.

---

## Risk Management Strategy

Given these limitations, this project adopts the following approach:

- **Constrain credential entry points**
  - Browser password manager controls
  - Approved password manager enforcement

- **Detect risky states**
  - Apple ID sign-in
  - iCloud service activation
  - Autofill usage on enterprise domains

- **Reduce blast radius**
  - MFA and Conditional Access
  - Reduced password reliance

- **Govern behavior**
  - Policy clarity
  - Exceptions
  - User education
  - Incident response

This strategy aligns with Apple platform security guidance.

---

## What This Project Does Not Claim

This project does **not** claim to:
- Fully disable macOS Keychain
- Prevent all credential storage
- Override user identity ownership
- Replace Apple’s security model

It claims to:
- Detect
- Constrain
- Govern
- Respond

---

## Summary

macOS Keychain security requires a **different mindset** than Windows or traditional endpoint lockdown.

- Some controls are intentionally unavailable
- Detection is more reliable than prevention
- Governance is a first-class control

> This project documents how to secure credentials on macOS without breaking platform guarantees.

``

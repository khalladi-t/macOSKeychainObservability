# macOS Keychain Architecture

## Purpose

This document provides a practical, security‑oriented overview of macOS Keychain architecture as it relates to **enterprise credential storage, synchronization, and observability**.

It is intended to:
- Establish clear definitions
- Eliminate ambiguity around “which keychain”
- Identify immutable trust boundaries
- Highlight realistic observability surfaces

---

## Top‑Level 

macOS credential handling consists of **three distinct layers**:

1. **Local keychain storage**
2. **Synchronization services**
3. **Hardware‑ and OS‑enforced protection boundaries**

This project focuses on **Layer 1 and Layer 2**, and treats Layer 3 as immutable.

---

## 1. Keychain Access

### Description

The **login keychain** is the default keychain associated with a user account.
It is unlocked automatically when the user logs in.

### Characteristics

- Stored in Keychain Access 
- Accessible to user‑approved apps
- Integrated with browsers and autofill services
- Encrypted with keys derived from the user’s login 
- Stored locally

### Common Contents

- Web app credentials
- Safari saved passwords
- Browser‑accessible secrets
- Wifi credentials (user scope)
- Application service tokens

### Security Relevance

✅ **This is the primary location where enterprise credentials are stored**  
✅ **This is the source of data for iCloud Keychain synchronization**  
✅ **This is the main interaction point for browsers and autofill**

> From an enterprise security perspective, controlling what enters Keychain Access
> is more impactful than attempting to control how it is stored.

---

## 2. iCloud Keychain (Synchronization Layer)

### Description

**iCloud Keychain is not a standalone keychain database.**

It is a **synchronization and escrow service** that mirrors eligible items from Keychain Access
to Apple’s iCloud infrastructure and across trusted devices.

### Characteristics

- Requires an authenticated Apple ID
- End‑to‑end encrypted
- Uses device trust and Secure Enclave–backed keys
- Selectively syncs supported credential classes
- Operates transparently once enabled

### Security Relevance

✅ Provides a **replication path** for Keychain Access credentials  
✅ Extends credential availability beyond enterprise‑managed devices  
✅ Significantly reduces enterprise visibility and control  

> The risk is not local storage — the risk is **uncontrolled replication**.

---

## 3. Sytems Keychain

### Description

The **System Keychain** stores credentials used by macOS itself.

### Characteristics

- Located at `users ~/Library/Keychains/System.keychain`
- Used for system services and machine‑level secrets
- Requires elevated privileges to modify
- Not used for browser autofill

### Security Position

❌ Not accessible to normal user workflows  
❌ Not synced via iCloud Keychain for web credentials  
❌ Not relevant to enterprise password manager replacement

---

## 4. App Specific Keychains 

### Description

Applications may create their own keychains or store secrets using
Application‑scoped Keychain APIs.

### Characteristics

- Protected by entitlements and sandboxing
- Often opaque to other applications
- Not universally synced
- Not integrated with browser autofill

### Security Position

⚠️ Relevant only if used for enterprise authentication  
⚠️ Generally lower risk than Login Keychain  
⚠️ Observed indirectly via application behavior

---

## 5. Secure Enclave & Hardware‑Backed Keys

### Description

The Secure Enclave protects cryptographic material that never leaves hardware.

### Examples

- Touch ID / Face ID keys
- Device unlock secrets
- Apple Pay material
- iCloud Keychain encryption keys

### Security Position

These are treated as **hard trust boundaries**.

---

## Process Architecture

The following system processes mediate Keychain behavior:

### Core Processes

- `securityd`  
  Handles keychain access control, encryption, and authorization.

- `icloudaccountd`  
  Manages Apple ID session state and iCloud service eligibility.

- `cloudd`  
  Handles CloudKit synchronization.

- `CloudKeychainProxy`  
  Coordinates keychain‑specific sync behavior.

### Observability Implication

While keychain contents are opaque:
- Process **state**
- Process **lifetime**
- Process **interaction patterns**
are observable and form the basis of detection logic.

---

## Browser Integration Path

Credentials typically enter the Login Keychain via browsers.

### Safari

- Native integration with Keychain Services
- First‑class iCloud Keychain support
- Autofill tightly coupled with OS services

### Chromium‑Based Browsers 

- Optional Keychain usage on macOS
- Can be constrained via policy
- Observable through browser configuration and behavior

### Architectural Insight

This is why **browser controls are a primary compensating control**.

---

## Observability Summary

| Layer | Observable | Notes |
|---|---|---|
| Login Keychain contents | ❌ No | Protected by design |
| Keychain access events | ✅ Partial | Via unified logging |
| Apple ID state | ✅ Yes | Strong risk signal |
| iCloud sync capability | ✅ Yes | Capability > content |
| Secure Enclave | ❌ No | Hard boundary |

---

## Architectural Implications for Security

- Attempting to “disable Keychain” is ineffective
- Credential **placement** matters more than storage
- Sync capability is the true risk multiplier
- Detection and governance outperform brute‑force prevention

---

## Summary

macOS Keychain architecture is intentionally resistant to inspection and control.
Enterprise credential security must therefore focus on:

- **Where credentials originate**
- **Whether they can replicate**
- **How users interact with autofill**
- **What behaviors indicate policy deviation**

> This project instruments the platform as designed,  
> rather than attempting to fight it.

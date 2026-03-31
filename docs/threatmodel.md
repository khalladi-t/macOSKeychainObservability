
## Purpose

This document defines the threat model for macOSKeychainObservability.

It describes:
- The isks are being addressed
- What adversary behaviors are in scope
- What protections exist by design

DefSec hreat model focused on visibility, containment, and governance.

---

## Assets at Risk

The primary assets of concern are:

- **Enterprise creds**
  - Web app un/pw
  - Federation fallback credentials
  - VPN credentials if applicable

- **Credential lifecycle metadata**
  - Where credentials are stored
  - How they are accessed
  - Whether they are synchronized off-device

Does not target cryptographic keys or hardware-backed secrets.

---

## Trust Boundaries

macOS introduces several hard trust boundaries that cannot be bypassed in a supported manner:

- **Secure Enclave**
- **System Integrity Protection (SIP)**
- **Apple ID–backed iCloud services**
- **End-to-end encrypted keychain sync**

---

## Threat Actors

### 1. Users

Characteristics:
- Signing into Apple ID on corporate devices
- Allowing Safari or macOS to “save passwords”
- Syncing credentials across personal devices unintentionally

Risk:
- Silent credential replication outside enterprise control

---

### 2. Malicious Insider (Limited Capability)

Characteristics:
- Intentional storage of credentials in non-approved managers
- Attempts to evade policy enforcement
- Use of built-in OS features to bypass controls

Constraints:
- No Secure Enclave compromise
- No kernel-level exploitation
- No SIP bypass

---

### 3. External Adversary (Post-Credential Compromise)

Characteristics:
- Obtains credentials via phishing, malware, or reuse
- Attempts to leverage synced credentials
- Uses credentials from non-corporate devices


---

## In-Scope Attack Scenarios

✅ **Credential Sync via iCloud Keychain**

✅ **Browser Autofill on Corporate Domains**
- Safari autofill saves enterprise credentials
- User unaware of keychain persistence

✅ **Shadow Password Managers**

✅ **Lack of Visibility**

---

## Out-of-Scope Scenarios

❌ Secure Enclave key extraction  
❌ Password database decryption  
❌ SIP or kernel bypass  
❌ Memory scraping of protected processes  
❌ Malware persistence mechanisms  

---



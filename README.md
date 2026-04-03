## macOSKeychainObservability

Observability, detection, and governance of macOS Login Keychain and iCloud Keychain usage in enterprise environments

<img width="229" height="229" alt="image" src="https://github.com/user-attachments/assets/1a5341f3-c7e2-46c9-bb48-1ed3b14b4299" />


## Getting Started

![Platform](https://img.shields.io/badge/platform-macOS-black?logo=apple)
![Security](https://img.shields.io/badge/focus-Security%20Engineering-critical)
![Observability](https://img.shields.io/badge/category-Endpoint%20Observability-blue)
![DevSecOps](https://img.shields.io/badge/practice-DevSecOps-brightgreen)
![Defensive](https://img.shields.io/badge/use-defensive%20only-success)

##  Overview

macOS provides strong, privacy‑preserving protections around credential storage through the Login Keychain, Secure Enclave, and iCloud Keychain. Greatly benefitting end‑user security, but creates challenges for enterprises that must:

* Prevent corporate credentials from being stored in unapproved password managers
* Avoid credential synchronization to personal Apple IDs
* Maintain visibility and auditability on credential handling
* Enforce use of approved tools

This repo documents an approach to observing, constraining, and governing macOS Keychain usage without attempting to break, bypass, or disable Apple security settings.

## Focuses
- **Login Keychain**
- [x] User‑accessible credential store
- [x] Browser‑integrated web passwords
- [x] Wi‑Fi and application secrets relevant to enterprise auth
- **iCloud Keychain**
- [x] Synchronization and escrow of eligible Login Keychain items
- [x] Apple ID–backed credential propagation beyond corporate control
- **Associated system processes**
- [x] securityd
- [x] icloudaccountd
- [x] CloudKeychainProxy
- [x] CloudKit‑related services
- **Browser integration surfaces**
- [x] Safari autofill
- [x] Chromium‑based browser password flows
- [x] Credential save and retrieve events


## ✅ In Scope

| Element                   | Purpose                             |
|------------------------------|----------------------------------|
| Login Keychain               | Stores enterprise credentials    |
| Safari / browser passwords   | Primary user behavior             |
| iCloud Keychain sync          | Exfiltration & replication path  |
| Keychain access APIs          | Observability surface             |

## iOS
iCloud Keychain is not a standalone vault - it is a synchronization layer for eligible Login Keychain items.
- https://developer.apple.com/documentation
- https://developer.apple.com/documentation/technotes/tn3137-on-mac-keychains


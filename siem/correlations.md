# Example SIEM Correlations

## Credential Sync Risk Escalation

### Logic

Sequence within 24 hours on same device:

1. apple_id_login
2. keychain_sync_capability
3. active_icloud_sync

### Resulting Alert

- Severity: Critical
- Confidence: High
- Playbook: active-icloud-sync

---

## Credential Ingress Risk

### Logic

- browser_autofill detected
AND
- keychain_sync_capability = true

### Resulting Alert

- Severity: Critical
- Immediate response 

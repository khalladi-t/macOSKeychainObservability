# Telemetry

## Purpose

The telemetry section documents observable signals on macOS that indicate
credential storage, synchronization, or usage risk.

Because macOS Keychain contents are intentionally opaque, this project
focuses on **behavioral and state-based telemetry**, rather than inspection.

Telemetry is used to:
- Identify high-risk configs
- Detect policy relevant changes
- Enable response and governance
- Provide audit visibility

---

## Telemetry Design Principles

- **State over content**  
  We detect *capability* and *behavior*, not secrets.

- **Supported observability only**  
  No SIP bypasses, no private frameworks, no exploitation.

- **Correlation-friendly**  
  Signals are designed to be combined, not used in isolation.

- **Low false positive bias**  
  Preference for stable, interpretable signals.

---

## Telemetry Categories

This repository groups telemetry into four categories:

1. **Account State**
   - Apple ID presence
   - iCloud service activation

2. **Process Activity**
   - Keychain and iCloud service processes
   - Long-lived service behavior

3. **Unified Logging**
   - Keychain access events
   - Sync attempts and failures

4. **Browser Signals**
   - Autofill usage
   - Password manager availability
   - Policy enforcement state

Each telemetry source has different fidelity and tradeoffs.

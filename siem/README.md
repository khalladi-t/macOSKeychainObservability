# SIEM Integration Guidance

## Purpose

This section describes how telemetry and detections in this repository
can be operationalized within a SIEM platform.

Defines:
- Expected event schemas
- Field normalization guidance
- Detection-to-alert mappings
- Correlation strategies
- Integration with response playbooks

This repo does not implement a SIEM.

---

## Design Principles

- SIEM-agnostic
- Human-readable and auditable
- Correlation-driven, not noisy
- Explicit severity mapping
- Clear handoff to response playbooks

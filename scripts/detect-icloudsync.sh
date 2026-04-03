#!/bin/bash

SYNC_ACTIVE=false

if pgrep "cloudd" >/dev/null 2>&1; then
  SYNC_ACTIVE=true
fi

echo "{\"icloud_sync_active\": $SYNC_ACTIVE}"

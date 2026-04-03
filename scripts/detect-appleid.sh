#!/bin/bash

USER_HOME=$(dscl . -read /Users/$USER NFSHomeDirectory | awk '{print $2}')
ICLOUD_PLIST="$USER_HOME/Library/Preferences/MobileMeAccounts.plist"

if [ -f "$ICLOUD_PLIST" ]; then
  echo '{"apple_id_configured": true}'
else
  echo '{"apple_id_configured": false}'
fi

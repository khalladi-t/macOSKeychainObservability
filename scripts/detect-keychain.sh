#!/bin/bash

processes=(
  "icloudaccountd"
  "cloudd"
  "CloudKeychainProxy"
  "securityd"
)

result="{"

for proc in "${processes[@]}"; do
  if pgrep "$proc" >/dev/null 2>&1; then
    result+="\"$proc\": true, "
  else
    result+="\"$proc\": false, "
  fi
done

result="${result%, }"
result+="}"

echo "$result"

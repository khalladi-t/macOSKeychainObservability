#!/bin/bash

# Example checks – expand per environment
CHROME_PREF="$HOME/Library/Preferences/com.google.Chrome.plist"
EDGE_PREF="$HOME/Library/Preferences/com.microsoft.Edge.plist"

chrome_pm="unknown"
edge_pm="unknown"

if [ -f "$CHROME_PREF" ]; then
  chrome_pm="present"
fi

if [ -f "$EDGE_PREF" ]; then
  edge_pm="present"
fi

echo "{
  \"chrome_profile_present\": \"$chrome_pm\",
  \"edge_profile_present\": \"$edge_pm\"
}"

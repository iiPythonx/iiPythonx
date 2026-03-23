#!/usr/bin/bash
# Copyright (c) 2025 iiPython

CURRENT=$(curl -s "https://wttr.in/?format=j2" | jq .data.current_condition[0])
TEMP=$(echo $CURRENT | jq -r .temp_F)
case $(echo $CURRENT | jq -r .weatherCode) in
    "350" | "374" | "377")                          ICON="󰖒" ;;  # Hail
    "386" | "389")                                  ICON="󰙾" ;;  # Lightning and rain
    "332" | "335" | "338" | "371")                  ICON="󰼶" ;;  # Moderate/heavy snow
    "323" | "326" | "329" | "368")                  ICON="󰖘" ;;  # Light snow
    "299" | "302" | "305" | "308" | "356" | "359")  ICON="󰖖" ;;  # Moderate/heavy rain
    "143" | "263" | "266" | "293" | "296" | "353")  ICON="󰖗" ;;  # Light rain
    "248" | "260")                                  ICON="󰖑" ;;  # Fog and freezing fog
    "119")                                          ICON="󰖐" ;;  # Cloudy
    "116")                                          ICON="󰖕" ;;  # Partly cloudy
    "113" | *)                                      ICON="󰖙" ;;  # Default (clear)
esac
echo "$ICON $TEMP°F"

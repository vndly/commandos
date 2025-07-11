#!/usr/bin/env bash

set -e

FOLDER="tool/json"
WHITELIST=("json_extra.dart" "json_extra.g.dart")

for file in "$FOLDER"/*; do
  basename=$(basename "$file")
  if [[ ! " ${WHITELIST[@]} " =~ " $basename " ]]; then
    rm -f "$file"
  fi
done

cp tool/../lib/domain/json/* tool/json/

dart tool/generate_maps.dart
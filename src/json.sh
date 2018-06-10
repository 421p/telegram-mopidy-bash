#!/usr/bin/env bash

import util/type

function map.toJson() {

    for key in "${!this[@]}"; do
        printf '%s\0%s\0' "$key" "${this[$key]}"
    done |
    jq -Rs '
      split("\u0000")
      | . as $a
      | reduce range(0; length/2) as $i
          ({}; . + {($a[2*$i]): ($a[2*$i + 1]|fromjson? // .)})' |
    sed -E 's/("(true|false|null)")/\2/'
}

function array.toJson() {
    this toJSON
}
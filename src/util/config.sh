#!/usr/bin/env bash

import util/namedParameters util/class
import ./logging.sh

class:Config() {
    function Config.get() {
        [string] query

        jq -rc "$query" < ${PWD}/config.json
    }
}

Type::InitializeStatic Config
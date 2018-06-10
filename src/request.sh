#!/usr/bin/env bash

import util/namedParameters util/class util/type
import ./json.sh

class:Request() {
    function Request.post() {
        [string] url
        [string] method
        [map] params

        map payload

        payload["method"]=${method}
        payload["params"]=${params}
        payload["jsonrpc"]='"2.0"'
        payload["id"]=$(od -An -N2 -i /dev/urandom | awk '{$1=$1};1')

        curl -sX POST ${url} -H 'Content-Type: application/json' -d "$($var:payload toJson)"
    }
}

Type::InitializeStatic Request
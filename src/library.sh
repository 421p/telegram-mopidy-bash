#!/usr/bin/env bash

import util/namedParameters util/class
import ./storage.sh
import ./json.sh

class:Library() {

    public string mopidyUri

    private Storage storage

    function Library.getTrackUri() {
        [string] albumName
        [string] trackName

        local key="$albumName:$trackName"

        this storage createIfNotExist

        if [ $(this storage isAlreadyAdded "$key") == 0 ]; then
            map parameters
            map query

            query["album"]=${albumName}

            parameters["query"]=$($var:query toJson)
            parameters["uris"]='["gmusic:"]'
            parameters["exact"]=false

            local uri=$(Request post $(this mopidyUri) "core.library.search" "$($var:parameters toJson)" \
            | jq "first(.result[0].tracks[] | select(.name == \"$trackName\").uri)")

            this storage addTrack "$key" "$uri"

            @return:value "$uri"

        else
            @return:value $(this storage getTrack "$key")
        fi
    }
}

Type::Initialize Library
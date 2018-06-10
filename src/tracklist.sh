#!/usr/bin/env bash

import util/namedParameters util/class
import ./json.sh

class:Tracklist() {

    public string mopidyUri

    function Tracklist.clear() {
        Request post $(this mopidyUri) "core.tracklist.clear" "{}"

    }

    function Tracklist.add() {
        [string] uri

        map parameters

        parameters["tracks"]=null
        parameters["at_position"]=null
        parameters["uri"]=null
        parameters["uris"]="[$uri]"

        Request post $(this mopidyUri) "core.tracklist.add" "$($var:parameters toJson)"
    }

    function Tracklist.enableRepeat() {
        map parameters

        parameters["value"]=true

        Request post $(this mopidyUri) "core.tracklist.set_repeat" "$($var:parameters toJson)"
    }

    function Tracklist.enableSingle() {
        map parameters

        parameters["value"]=true

        Request post $(this mopidyUri) "core.tracklist.set_single" "$($var:parameters toJson)"
    }

    function Tracklist.disableRepeat() {
        map parameters

        parameters["value"]=false

        Request post $(this mopidyUri) "core.tracklist.set_repeat" "$($var:parameters toJson)"
    }

    function Tracklist.disableSingle() {
        map parameters

        parameters["value"]=false

        Request post $(this mopidyUri) "core.tracklist.set_single" "$($var:parameters toJson)"
    }
}

Type::Initialize Tracklist
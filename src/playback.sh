#!/usr/bin/env bash

import util/namedParameters util/class
import ./json.sh

class:Playback() {

    public string mopidyUri

    function Playback.play() {
        map pp

        pp["tlid"]=null
        pp["tl_track"]=null

        Request post $(this mopidyUri) "core.playback.play" "$($var:pp toJson)"
    }
}

Type::Initialize Playback
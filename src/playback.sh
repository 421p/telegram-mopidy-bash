#!/usr/bin/env bash

import util/namedParameters util/class
import ./json.sh

class:Playback() {

    public string mopidyUri

    function Playback.play() {
        Request post $(this mopidyUri) "core.playback.play" '{ "tlid": null, "tl_track": null }'
    }

    function Playback.pause() {
        Request post $(this mopidyUri) "core.playback.pause" '{}'
    }
}

Type::Initialize Playback
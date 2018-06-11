#!/usr/bin/env bash

import util/namedParameters util/class
import ./json.sh

class:Mixer() {

    public string mopidyUri

    function Mixer.setVolume() {
        [integer] volume

        Request post $(this mopidyUri) "core.mixer.set_volume" "{\"volume\": $volume}"
    }
}

Type::Initialize Mixer
#!/usr/bin/env bash

import util/namedParameters util/class util/type

import ./json.sh
import ./request.sh
import ./tracklist.sh
import ./library.sh
import ./playback.sh
import ./mixer.sh
import ./storage.sh
import ./util/config.sh
import ./util/logging.sh

class:Player() {

    private Tracklist list
    private Library lib

    public Playback playback
    public Mixer mixer

    function Player.init() {
        local uri="$(Config get '.mopidy_uri')"

        this list mopidyUri = ${uri}
        this playback mopidyUri = ${uri}
        this mixer mopidyUri = ${uri}
        this lib mopidyUri = ${uri}
    }
    
    function Player.playSong() {
        [string] album
        [string] name

        log "Clearing playlist.."

        this list clear > /dev/null &

        log "Adding song $name from album $album"

        log "$(this list add $(this lib getTrackUri "$album" "$name") | jq '.')" &

        wait

        this list enableSingle | jq '.' > /dev/null &
        this list enableRepeat | jq '.' > /dev/null &

        this playback play > /dev/null &
    }
}

Type::Initialize Player
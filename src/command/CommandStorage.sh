#!/usr/bin/env bash

import util/namedParameters util/class
import ./../player.sh

class:CommandStorage() {

    private Player player

    function CommandStorage.init() {
        this player init
    }

    function CommandStorage.execute() {
        [string] commandName

        log "Trying to execute '$commandName'"

        local cmd='Priton'
        if [[ "$commandName" =~ ${cmd} ]]; then
            log "Priton command activated."
            this player playSong "Дом с нормальными явлениями" "Притон"

            echo "Вы на самом дне притона"

            return
        fi

        local cmd="Dark Sun"
        if [[ "$commandName" =~ ${cmd} ]]; then
            log "Dark Sun command activated."
            this player playSong "Solar Echoes" "Dark Sun"

            echo "Behold the Dark Sun."

            return
        fi

        local cmd="Utulek"
        if [[ "$commandName" =~ ${cmd} ]]; then
            log "Utulek command activated."
            this player playSong "Deus Ex: Extended" "Utulek Restricted"

            echo "Welcome to the Golem City."

            return
        fi

        local cmd="Prague"
        if [[ "$commandName" =~ ${cmd} ]]; then
            log "Prague command activated."
            this player playSong "Deus Ex: Extended" "Prague Ambient 010"

            echo "Welcome to the Prague."

            return
        fi

        local cmd="Neuromonk"
        if [[ "$commandName" =~ ${cmd} ]]; then
            log "Neuromonk command activated."
            this player playSong "Тропа" "На дворе"

            echo "Надевайте косоворотки да расписные рубахи!"

            return
        fi

        local cmd="Depression"
        if [[ "$commandName" =~ ${cmd} ]]; then
            log "Depression command activated."
            this player playSong "Melody Of Certain Damaged Lemons" "For the Damaged Coda"

            echo "For what? For the damaged coda."

            return
        fi

        local cmd="Volume ([0-9]+)"
        if [[ "$commandName" =~ ${cmd} ]]; then
            log "Volume command activated."

            local vol=${BASH_REMATCH[1]}
            this player mixer setVolume ${vol} } > /dev/null

            echo "Current volume: $vol"

            return
        fi

        local cmd="/start"
        if [[ "$commandName" =~ ${cmd} ]]; then
            echo "Hi there."

            return
        fi

        log "Unknown command. Skipping."
        echo 0
    }
}

Type::Initialize CommandStorage
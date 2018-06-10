#!/usr/bin/env bash

import util/namedParameters util/class
import ./util/logging.sh
import ./util/config.sh
import ./command/CommandStorage.sh

class:Bot() {

    public string token

    private integer offset = 0
    private integer timeout = 120

    private string replyMarkup = "$(Config get '.reply_markup')"

    private CommandStorage commands

    function Bot.poll() {
        curl -sX POST \
          https://api.telegram.org/bot$(this token)/getUpdates \
          -H 'Content-Type: multipart/form-data' \
          -F offset=$(this offset) \
          -F timeout=$(this timeout) | jq -r '.result[] | @base64'
    }

    function Bot.run() {
        this commands init

        while true; do

            log 'polling updates...'

            local response=$(this poll)

            if [ ! -z "${response}" ]; then
                for encodedUpdate in ${response}; do

                    update=$(base64 -d <<< ${encodedUpdate})

                    updateId=$(jq '.update_id' <<< ${update})
                    messageText=$(jq -r '.message.text' <<< ${update})
                    firstName=$(jq -r '.message.from.first_name' <<< ${update})
                    userId=$(jq '.message.from.id' <<< ${update})
                    chatId=$(jq '.message.chat.id' <<< ${update})

                    this handleUpdate ${userId} ${chatId} "$firstName" "$messageText"

                    this offset = $(($updateId + 1))
                done
             else
                log 'no updates available.'
            fi
        done
    }

    function Bot.handleUpdate() {
        [integer] userId
        [integer] chatId
        [string] firstName
        [string] text

        log "[$chatId] $firstName: $text"

        local isAllowed=$(Config get ".allowed_users | index($userId) != null")

        if [ "$isAllowed" == "true" ]; then
            local text="$(this commands execute "${text}")"

            if [ "$text" != 0 ]; then
                this sendMessage ${chatId} "${text}"
            fi
        else
            log "$firstName ($userId) is not allowed to execute commands."
            this sendMessage ${chatId} "🚫 You are not a member of Priton community. 🚫"
        fi
    }

    function Bot.sendMessage() {
        [integer] chatId
        [string] text

        local response=$(curl -sX POST \
            https://api.telegram.org/bot$(this token)/sendMessage \
            -H 'Content-Type: multipart/form-data' \
            -F text="$text" \
            -F chat_id=${chatId} \
            -F reply_markup="$(this replyMarkup)")

        if [ $(jq -r '.ok' <<< "$response") == 'true' ]; then
            log "Successfully sent message to $chatId"
        else
            log "ERROR!"
            log "$response"
        fi
    }
}

Type::Initialize Bot




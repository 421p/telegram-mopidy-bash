#!/usr/bin/env bash

import util/log

function log() {
    Console::WriteStdErr "$(UI.Color.Yellow)[$(printf '%(%Y-%m-%d %H:%M:%S)T')] $(UI.Color.Default)$*"
}
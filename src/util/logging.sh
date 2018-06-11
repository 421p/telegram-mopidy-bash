#!/usr/bin/env bash

import util/log

function log() {
    Console::WriteStdErr "$(UI.Color.Yellow)[$(date +"%Y-%m-%d %H:%M:%S:%3N")] $(UI.Color.Default)$*"
}
#!/usr/bin/env bash

source "$( cd "${BASH_SOURCE[0]%/*}" && pwd )/lib/oo-bootstrap.sh"

import ./src/bot.sh
import ./src/util/config.sh

Bot bot

$var:bot token = $(Config get '.telegram_token')

$var:bot run
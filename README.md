## Proof of Concept
First of all, this project is a proof of concept that proves usability of Bash scripting language in a modern environment. It works but it still far from being a perfect app.

## Features

* Basic Telegram API - receiving updates (long polling) and sending messages.
* Basic Mopidy API - adding tracks (Google Music only, so Mopidy-Gmusic is required for mopidy backend), setting play mode and volume.
* High readability via [Bash Infinity](https://github.com/niieani/bash-oo-framework) (OOP paradigm in Bash)
* JSON configuration
* caching via SQLite3

## Dependencies

* Bash 4
* [jq](https://stedolan.github.io/jq/)
* [SQLite3](https://www.sqlite.org/index.html)

On Debian/Ubuntu you can install both via
```sh
sudo apt-get install jq sqlite3
```

## Installation

First, clone this repository
```
git clone https://github.com/421p/telegram-mopidy-bash.git
```

Then, edit a `config.json` by adding your `telegram_token` and `allowed_users`. Probably you also want to change `mopidy_uri` if it's running somewhere else.

And now you are ready to start bot:
```
./bot.sh
```

## Modifying bot for your own needs

You can modify bot commands by changing only 2 things:
* bot keyboard (`reply_markup` in `config.json`) 
* executed code (`src/command/CommandStorage.sh`)

Also, you may totally remove mopidy-related code and use this as bash-telegram-bot boilerplate. Or even vice versa.

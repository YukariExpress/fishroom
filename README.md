# fishroom
![GPL license](https://img.shields.io/badge/license-GPL-blue.svg)
![Proudly Powered by Python3](https://img.shields.io/badge/python-3.5-blue.svg)
[![Join Fishroom](https://img.shields.io/badge/%23chat-fishroom-brightgreen.svg)](https://fishroom.tuna.moe/)

Message forwarding for multiple IM protocols

## Motivation

TUNA needs a chatroom, while each IM protocol/software has its own
implementation for chatroom.

Unlike email and mailing list, instant messaging is fragmented: everyone prefers
different softwares. As a result, people of TUNA are divided by the IM they use,
be it IRC, WeChat, telegram, or XMPP.

To reunify TUNA, we created this project to relay messages between IM clients,
so that people can enjoy a big party again.

## Supported IMs

- IRC
- XMPP
- [Matrix](https://matrix.org)
- Telegram
- Gitter
- Actor (not yet)
- Tox (not yet)
- WeChat (maybe)

## Basic Architecture

Fishroom consists of a *fishroom core* process, which routes messages among IMs
and process commands, and several IM handler processes to deal with different
IMs. These components are connected via Redis pub/sub.

```Text
+----------+
| IRC      |<-+
+----------+  |
+----------+  |
| XMPP     |<-+
+----------+  |
+----------+  |    +-------+       +---------------+
| Telegram |<-+--> | Redis | <---> | Fishroom Core |
+----------+  |    +-------+       +---------------+
+----------+  |
| Gitter   |<-+
+----------+  |
+----------+  |
| Web      |<-+
+----------+
```

## How to Use

Clone me first

```ShellSession
git clone https://github.com/tuna/fishroom
cd fishroom
```

### Docker Rocks

Uses the following command to build the fishroom image.

```ShellSession
docker build --rm -f Dockerfile -t fishroom:latest .
```

Create the configuration file `config.json` and place it in the same directory
as the `Dockerfile`.

Adjust `docker-compose.yml` to adds the appropriate handlers.
Using the environment variable `FISHROOM_MODE` to pass the name of the handler.

Uses the following command to deploy the stack:

```ShellSession
docker stack deploy -c docker-compose.yml fishroom
```

### Docker Sucks

Install and run Redis first, assuming you use Ubuntu or Debian.

```ShellSession
apt-get install redis
```

Modify the config file. the Redis server should listen on address `127.0.0.1`
and port `6379`.

```ShellSession
mv fishroom/config/config.json.example fishroom/config/config.json
vim fishroom/config/config.json.example
```

Ensure your python version is at least 3.5, next, we install the dependencies
for fishroom.

```ShellSession
apt-get install -y\
    python3-dev\
    python3-pip\
    libmagic1\
    libjpeg-dev\
    libpng-dev\
    libwebp-dev\
    zlib1g-dev\
    gcc
pip3 install --upgrade pip setuptools
pip3 install -r requirements.txt
```

Run fishroom and handlers.

```ShellSession
# run fishroom core
python3 -m fishroom.fishroom

# start IM interfaces, select not all of them are needed
python3 -m fishroom.telegram
python3 -m fishroom.IRC
python3 -m fishroom.gitter
python3 -m fishroom.xmpp

python3 -m fishroom.web
```

Open your browser and visit <http://127.0.0.1:8000/>. You should be able to see
the web UI of fishroom.

Good Luck!

## Related Projects

- [Telegram2IRC](https://github.com/tuna/telegram2irc)
- [Telegram Bot API](https://core.telegram.org/bots/api)
- [IRCBindXMPP](https://github.com/lilydjwg/ircbindxmpp)
- [SleekXMPP](https://pypi.python.org/pypi/sleekxmpp)
  - [Multi-User Chat Supported](http://sleekxmpp.com/getting_started/muc.html)
- [Tox-Sync](https://github.com/aitjcize/tox-irc-sync)
- [qwx](https://github.com/xiangzhai/qwx)

## License

```Text
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
```

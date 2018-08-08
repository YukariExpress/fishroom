#!/usr/bin/env python

import os
import json

config_path = os.path.join(
    os.path.dirname(__file__),
    "config",
    "config.json"
)

with open(config_path, "r") as f:
    config = json.load(f)

# vim: ts=4 sw=4 sts=4 expandtab

#!/usr/bin/env python

import json
import requests
from datetime import datetime

data = {}

weather = requests.get(
    "https://api.open-meteo.com/v1/forecast?latitude=43.6109&longitude=3.8763&current_weather=true"
).json()

data["text"] = f"{weather['current_weather']['temperature']}°"

print(json.dumps(data))

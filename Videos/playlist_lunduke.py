#!/usr/bin/env python3
import requests

r = requests.get("https://feed.eugenemolotov.ru/?action=display&bridge=Youtube&c=UCkK9UDm_ZNrq_rIXCz3xCGA&duration_min=&duration_max=&format=Json")
for item in r.json()["items"]:
    print(item["url"])

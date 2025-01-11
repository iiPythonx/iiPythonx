#!/usr/bin/python3
# Copyright (c) 2025 iiPython
# A very dumb script to add Feishin's synced lyrics to waybar.

# Modules
import json
import asyncio
from base64 import b64encode

from websockets.asyncio.client import connect
from websockets.exceptions import ConnectionClosedError

# Configuration
USERNAME = "feishin"

# I know, this is "unsafe".
# In addition to being "unsafe", it's also randomly generated and Feishin isn't accessible from anything other then my local machine.
# If you're looking at this and don't like it, get a life.
PASSWORD = "Lfln2z1B"

# Handle connection
async def process_lyrics(lyrics: list[dict], time: float) -> None:
    try:
        time *= 1000
        passed_lyrics = sorted([line for line in lyrics if line["start"] >= time], key = lambda line: line["start"])
        for lyric in passed_lyrics:
            await asyncio.sleep((lyric["start"] - time) / 1000)
            time = lyric["start"]
            print(lyric["value"], flush = True)

    except asyncio.CancelledError:
        print("", flush = True)

async def main():

    # Handle state
    lyrics: None | list[dict] = None
    lyrics_task: None | asyncio.Task = None
    last_time: float = 0.0

    while True:
        try:
            async with connect("ws://localhost:4333") as websocket:
                await websocket.send(json.dumps({"event": "authenticate", "header": f"Basic {b64encode(f'{USERNAME}:{PASSWORD}'.encode()).decode()}"}))

                while True:
                    data = json.loads(await websocket.recv())
                    match data:
                        case {"data": "paused", "event": "playback"} if lyrics_task is not None:
                            lyrics_task.cancel()
                            lyrics_task = None

                        case {"data": current_time, "event": "position"} if lyrics is not None:
                            if abs(current_time - last_time) > 1.1 and lyrics_task is not None:
                                lyrics_task.cancel()
                                lyrics_task = None

                            if lyrics_task is None:
                                lyrics_task = asyncio.create_task(process_lyrics(lyrics, current_time))

                            last_time = current_time

                        case {"data": song, "event": "song" | "state" as event_type}:
                            print(song, event_type)
                            if event_type == "state" and "song" not in song:
                                continue

                            if lyrics_task is not None:
                                lyrics_task.cancel()
                                lyrics_task = None

                            raw_lyrics = json.loads((song if event_type == "song" else song["song"])["lyrics"])
                            lyrics = raw_lyrics[0]["line"] if raw_lyrics else None

        except (OSError, ConnectionClosedError):
            if lyrics_task is not None:
                lyrics_task.cancel()
                lyrics_task = None

            print("", flush = True)
            await asyncio.sleep(10)

# Launch script
if __name__ == "__main__":
    asyncio.run(main())

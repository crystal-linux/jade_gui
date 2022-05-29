#!/usr/bin/python
import asyncio
import websockets
import json
import subprocess
import os
import sys
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad, pad
from base64 import b64decode, b64encode

def decrypt(message, key, iv):
    aes = None
    aes = AES.new(key, AES.MODE_CBC, iv)
    return unpad(aes.decrypt(b64decode(message)), AES.block_size).decode('utf-8')

def encrypt(message, key, iv):
    aes = None
    aes = AES.new(key, AES.MODE_CBC, iv)
    return b64encode(aes.encrypt(pad(message.encode('utf-8'), AES.block_size))).decode('utf-8')

# create handler for each connection
async def handler(websocket):
    aeskey = bytes(sys.argv[1], 'utf-8')
    data = await websocket.recv()
    print(data);
    parsed = json.loads(data)
    print(parsed['iv'])
    iv = b64decode(bytes(parsed['iv'], 'utf-8'))
    print(iv)
    print(len(iv))
    msgType = decrypt(parsed['type'], aeskey, iv)
    if msgType == "get":
        search = decrypt(parsed['search'], aeskey, iv)
        if search == "disks":
            partitions = subprocess.check_output(["bash", "-c", "lsblk -pdo name | grep -v zram | grep -v NAME | grep -v loop | grep -v sr"]).decode("utf-8")
            await websocket.send(json.dumps({"type": "response", "data": partitions}))
        elif search == "diskType":
            disk = decrypt(parsed['disk'], aeskey, iv)
            diskType = subprocess.check_output(["bash", "-c", "lsblk -d -o rota "+disk+" | grep -v ROTA"])
            await websocket.send(json.dumps({"type": "response", "data": diskType.decode("utf-8").strip()}))
        elif search == "diskSize":
            disk = decrypt(parsed['disk'], aeskey, iv)
            diskSize = subprocess.check_output(["bash", "-c", "lsblk -pdo size "+disk+" | grep -v SIZE"])
            await websocket.send(json.dumps({"type": "response", "data": diskSize.decode("utf-8").strip()}))
        elif search == "isEfi":
            if os.path.exists("/sys/firmware/efi"):
                await websocket.send(json.dumps({"type": "response", "data": "UEFI"}))
            else:
                await websocket.send(json.dumps({"type": "response", "data": "BIOS"}))
        elif search == "encryptPass":
            data = decrypt(parsed['pass'], aeskey, iv)
            password = subprocess.check_output(["bash", "-c", "openssl passwd -crypt "+data])
            await websocket.send(json.dumps({"type": "response", "data": password.decode("utf-8").strip()}))
    elif msgType == "send":
        command = decrypt(parsed['command'], aeskey, iv)
        if command == "installConfig":
            data = decrypt(parsed['data'], aeskey, iv)
            config = open('/tmp/jade.json', 'w')
            config.write(data)
            config.close()
            subprocess.check_output(["gnome-terminal", "--", "/bin/bash -c", "/usr/bin/sudo /usr/bin/jade config /tmp/jade.json"])
            await websocket.send(json.dumps({"type": "response", "data": "Finished Installing"}))
    else:
        await websocket.send(json.dumps({"type": encrypt("response", aeskey, iv), "data": encrypt("Invalid Request", aeskey, iv)}))
ip = subprocess.check_output(["bash", "-c", "hostname -i | awk '{print $3}'"]).decode("utf-8").strip()
start_server = websockets.serve(handler, ip, 8080)
asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()


#!/usr/bin/python
import os
import json
import yaml
import requests

def formatUUID(uuid):
    return uuid[0:8] + '-' + uuid[8:12] + '-' + uuid[12:16] + '-' + uuid[16:20] + '-' + uuid[20:32]
def getUUID(username):
    return formatUUID(requests.get('https://api.mojang.com/users/profiles/minecraft/' + username).json()['id'])

print("Generating Configuration...")
os.mkdir("config")

ops = []
env_ops = os.environ.get('ops')
env_motd = os.environ.get('motd')
env_ms = os.environ.get('ms')
env_mx = os.environ.get('mx')
ms = "1G"
mx = "1G"

ops_file = open('config/ops.json', 'w')
default_config_file = open('glowstone.yml.dist', 'r')
config_file = open('config/glowstone.yml', 'w')

config = yaml.load(default_config_file)

if env_ops is not None:
    for op in env_ops.split(','):
        opdata = op.split(':')
        if len(opdata) == 2:
            name = opdata[0]
            uuid = opdata[1]
        else:
            name = opdata[0]
            print("*** UUID for " + name + " not specified. Retreving from Mojang API...")
            uuid = getUUID(name)
        ops.append({'name': name, 'uuid': uuid})
if env_motd is not None:
    config['server']['motd'] = env_motd
if env_ms is not None:
    ms = env_ms
if env_mx is not None:
    mx = env_mx

json.dump(ops, ops_file) # Save config/ops.json
yaml.dump(config, config_file) # Save config/glowstone.yml

# Close the open files before we start the server 
ops_file.close()
default_config_file.close()
config_file.close()

print("Starting Server...")
os.system("/usr/bin/java -Xmx" + mx + " -Xms" + ms + " -jar glowstone.jar")

#!/usr/bin/env python

import os
import json
import subprocess
import time
import requests
import sys

if len( sys.argv ) < 2 :
    country = 'mx'
else :
    country = sys.argv[1]

os.chdir("/etc/openvpn/configs")

# Command to kill any running instances of OpenVPN
kill_command = "sudo killall openvpn"

# URL to the NordVPN server connection tool obtained from the browser
url_base = 'https://nordvpn.com/wp-admin/admin-ajax.php?action=servers_recommendations&'

country_filters = {
    'mx' : 'filters={%22country_id%22:140}',
    'us' : 'filters={%22country_id%22:228}',
    'uk' : 'filters={%22country_id%22:227}',
    'at' : 'filters={%22country_id%22:14}',
    'de' : 'filters={%22country_id%22:81}'
}

url = url_base + country_filters[country]

def start_openvpn_connection():
    response = requests.get(url)

    if len(response.text) != 2:
        nvpn_response = json.loads(response.text)
        vpn_info = nvpn_response[0]
        vpn_info_hostname = vpn_info["hostname"]
        vpn_file = vpn_info_hostname + ".udp.ovpn"

        # Command to start Openvpn
        ov_command = "sudo openvpn --config " + vpn_file

        # Start the NordVPN connection
        subprocess.Popen(ov_command.split())

if __name__ == "__main__":
    subprocess.Popen(kill_command.split())
    time.sleep(2)
    start_openvpn_connection()

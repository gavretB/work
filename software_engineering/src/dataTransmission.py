import socket
from contextlib import closing
import sys
from datetime import datetime

def data_transmission(opened):
    s = socket.socket()

    host = '172.25.40.11'
    port = 5000
    now = datetime.now()

    s.connect((host, port))
    s.send(opened.encode(encoding='utf-8'))
    #while True:
     #   print host, s.recv(4096)
    return
data_transmission("123456782,opened," + datetime.now().strftime("%Y-%m-%d %H:%M:%S"))

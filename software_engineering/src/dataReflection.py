import socket
from datetime import datetime
from time import sleep
import subprocess

morning = [0,0]
noon    = [0,0]
afternoon = [0,0]
night   = [0,0]
def sockettest():
    t = socket.socket()

    port = 2342
    t.bind(('172.25.38.24',port))

    while True:
      print('listening')
      t.listen(1)
      c, addr = t.accept()
      print('receiving')
      #値受け取り
      data = c.recv(4096)
      #値を文字列に変換
      data = data.decode(encoding='utf-8')
      print(data)
      #各設定時間ごとに分割
      alarmtime = data.split(" ")
      global morning
      global noon
      global afternoon
      global night
      morning = alarmtime[0].split(":")
      noon = alarmtime[1].split(":")
      afternoon = alarmtime[2].split(":")
      night = alarmtime[3].split(":")
      print(morning)
      print(noon)
      print(afternoon)
      print(night)

      c.close()
    t.close()

sockettest();

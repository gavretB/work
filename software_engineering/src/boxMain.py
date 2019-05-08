
import datetime
import alarm as al
import time
import openSensor as oS
import dataTransmisson as dT
import threading


morning = [1,4] #設定時間（後で消す）
noon = [2,5]
afternoon = [3,10]
night = [4,15]

def timing():

    thread_1 = threading.Thread(target=al.alarm)
    for i in range(5):
        time.sleep(1)
        if(i == 2):
            dT.state = 1
            print('opend')
            break
        if(i <= 2):
            thread_1.start()
            print('alarm')
        if(i == 4):
            dT.state = 0
            print('close')
    oS.open = 0

if __name__ == '__main__':
    go = 0
    now = datetime.datetime.now()#現在時刻取得
    print(now.hour , now.minute)
    while True:
        now = datatime.datatime.now()#現在時刻取得
        #if(morning[0] == now.hour or noon[0] == now.hour or afternoon[0] == now.hour or night[0] == now.hour):
'''
        if(le.go != go)             #お出かけ中
            dT.date_transmisson()   #データ送信呼び出し
'''
        elif(morning[0] == now.hour and morning[1] == now.minute):#mornngとマッチ
            timing()                #アラーム呼び出し
            dT.date_transmisson()   #データ送信呼び出し
            print('morning')
        elif(noon[0] == now.hour and noon[1] == now.minute):
            timing()
            dT.date_transmisson()
            print('noon')
        elif(afternoon[0] == now.hour and afternoon[1] == now.minute):
            timing()
            dT.date_transmisson()
            print('afternoon')
        elif(night[0] == now.hour and night[1] == now.minute):
            timing()
            dT.date_transmisson()
            print('night')
        else:
            time.sleep(1)

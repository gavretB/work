'''
# count変数が0より大きい間、繰り返す例
count = 10
while count > 0:
    print(count)
    count -= 1
print('処理を終了する')
'''
'''
while True:
    command = input('pybot> ')
    if 'こんにちは' in command:
        print('コンニチワ')
    elif 'ありがとう' in command:
        print('ドウイタシマシテ')
    elif 'さようなら' in command:
        print('サヨウナラ')
        break
    else:
        print('何ヲ言ッテルカ、ワカラナイ')
'''
'''
# 辞書データのあいさつを返す会話botを作る
bot_dict = {
    'こんにちは': 'コンニチワ',
    'ありがとう': 'ドウイタシマシテ',
    'さようなら': 'サヨウナラ'
}

while True:
    command = input('pybot> ')
    response = ''
    for message in bot_dict: # キーを順番に取り出す
        if message in command:
            response = bot_dict[message] #応答となる文字列を設定
            break
    if not response: # から文字列ではない場合
        response = '何ヲ言ッテルカ、ワカラナイ'
    print(response)

    if 'さようなら' in command:
        break
'''
#import
from pybot_eto import eto_command
from pybot_random import choice_command, dice_command
from pybot_datetime import today_command, now_command, weekday_command
from pybot_weather import weather_command
from pybot_wikipedia import wikipedia_command

# 長さコマンドの関数を作成
def len_command(command):
    cmd, text = command.split() # 文字列を取得
    length = len(text)
    response = '文字列ノ長サハ {} 文字デス'.format(length)
    return response


# 平成コマンドの関数を作成
def heisei_command(command): # 関数を定義
    heisei, year_str = command.split()
    if year_str.isdigit():
        year = int(year_str)
        if year >= 1989:
            heisei_year = year - 1988
            response = '西暦{}ハ、平成{}デス'.format(year, heisei_year)
        else:
            response = '西暦{}年ハ、平成デハアリマセン'.format(year)
    else:
        response = '数値ヲ指定シテクダサイ'
    return response # 結果を返す

# 挨拶データをファイルから取得する会話botを作る
# 挨拶の定義ファイルデータを行ごとの文字列データにする
command_file = open('pybot.txt', encoding='UTF-8')
raw_data = command_file.read()
command_file.close()
lines = raw_data.splitlines()
# 挨拶の辞書データを生成する
bot_dict = {}
for line in lines:
    word_list = line.split(',') # カンマで2つの文字列に分割
    key = word_list[0]
    response = word_list[1]
    bot_dict[key] = response # 辞書にセット

# while True:
def pybot(command):
    # command = input('pybot> ')
    response = ''
    try:
        for key in bot_dict:
            if key in command:
                response = bot_dict[key]
                break
        if '平成' in command: # 「平成」が含まれる場合
            response = heisei_command(command)
        '''
            heisei, year_str = command.split() # 文字列を分割
            year = int(year_str) # str -> int
            if year >= 1989: # 平成の範囲
                heisei_year = year - 1988 # 平成の年を計算
                response = '西暦{}年ハ、平成{}デス'.format(year, heisei_year)
            else:
                response = '西暦{}年ハ、平成デハアリマセン'.format(year)
        '''

        if '長さ' in command:
            response = len_command(command)

        if '干支' in command:
            response = eto_command(command)

        if '選ぶ' in command:
            response = choice_command(command)

        if 'さいころ' in command:
            response = dice_command()

        if '今日' in command:
            response = today_command()

        if '現在' in command:
            response = now_command()

        if '曜日' in command:
            response = weekday_command(command)

        if '天気' in command:
            response = weather_command()

        if '辞典' in command:
            response = wikipedia_command(command)

        if not response:
            response = '何ヲ言ッテルカ、ワカラナイ'
        #print(response)
        return response

        # if 'さようなら' in command:
        #    break
    except Exception as e:
        print('予期セヌ エラーガ 発生シマシタ')
        print('* 種類:', type(e))
        print('* 内容:', e)

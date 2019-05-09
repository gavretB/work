from bottle import route, run, template, request
from datetime import datetime
from pybot import pybot

@route('/hello') # URL指定
def hello():
    # return 'Hello World!' # レスポンスを返す
    now = datetime.now()
    # return template('Hello World! {{now}}', now=now)
    # return template('pybot_template', now=now)
    return template('pybot_template', input_text='', output_text='', now=now)

@route('/hello', method='POST') # POSTを追加
def do_hello():
    now = datetime.now()
    input_text = request.forms.input_text # request.forms.バラメータ名で取得
    output_text = pybot(input_text)
    return template('pybot_template', input_text=input_text, output_text=output_text, now=now) # 値を渡す

run(host='localhost', port=8080, debug=True) # 開発サーバを起動

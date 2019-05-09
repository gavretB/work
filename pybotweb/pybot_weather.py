import requests

def weather_command():
    base_url = 'http://weather.livedoor.com/forecast/webservice/json/v1'
    city_code = '130010' # 東京
    url = '{}?city={}'.format(base_url, city_code)
    # 天気予報データを取得
    r = requests.get(url)
    weather_data = r.json()
    city = weather_data['location']['city'] # 都市名
    label = weather_data['forecasts'][0]['dateLabel'] # 日付
    telop = weather_data['forecasts'][0]['telop'] # 天気

    response = '{}ノ{}ノ天気ハ「{}」デス'.format(city, label, telop)
    return response

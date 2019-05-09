import wikipedia

def wikipedia_command(command):
    cmd, keyword = command.split(maxsplit=1) # キーワードを抜き出す
    wikipedia.set_lang('ja')
    try:
        page = wikipedia.page(keyword) # ページを取得
        title = page.title
        summary = page.summary
        response = 'タイトル: {}\n{}'.format(title, summary) # 応答を生成
    except wikipedia.exceptions.PageError: # ページが見つからない場合
        response = '「{}」ノ意味ガ見ツカリマセンデシタ'.format(keyword)
    return response

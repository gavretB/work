<html><head><style>
ul {
  background-color: #f2feff;
  border: solid 2px #51d0a8;
  border-radius: 4px;
  padding: 36px;
  font-family: sans-serif;
  font-size: 24px;
}
</style>
</head>
<body>
<h1>pybot_webアプリケーション</h1>
<form method='post' action='/hello'>
メッセージを入力してください: <input type='text' name='input_text'>
<input type='submit' value='送信'>
</form>
<ul>
<li>入力メッセージ: {{input_text}}</li>
<li>pybotからの応答メッセージ: {{output_text}}</li>
</ul>
</body>
</html>

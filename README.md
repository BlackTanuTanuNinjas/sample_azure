# SampleAzure

Azure IoT Hubでメッセージ送信のサンプルコード

# 使い方

`config.ex`にコメントアウトを削除してサブスクリプションID、IotHub名、デバイスIDを記述する。

その後次のコマンドを実行する
1. `mix deps.get`
2. `iex -S mix`
3. `SampleAzure.send_message("<送信したいメッセージ>")`
   * ログインしていないときは`SampleAzure.send_message("<送信したいメッセージ>", true)`
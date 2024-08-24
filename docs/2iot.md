**注：本リポジトリはまだ絶賛準備中であり，ハンズオン当日までに内容が更新されることがあります．当日を楽しみにお待ちください,,,;(**

# ハンズオン２：組込みと繋げる

組込みマイコン向けの[zenoh-pico](https://github.com/eclipse-zenoh/zenoh-pico)を用いて，前段のPhoenixアプリと繋げてみましょう！

## プロジェクトの設定

このリポジトリにある `zenoh_pico/` のディレクトリをVSCodeで開きます（File -> Open Folder... など）．
初回のオープン時にはプロジェクト設定が走りますので，ウインドウ下の "OUTPUT" に `Project has been sucessfully updated!` が表示されるまで待ちます．

最下部にある "PlatformIO Toolbar" だけで様々な操作が行えます．各ボタンの説明は下記をご参照ください．  
https://docs.platformio.org/en/latest/integration/ide/vscode.html#platformio-toolbar

最下部 "PlatformIO Toolbar" の "Project Environment Switcher" をクリックして， `env:m5stack-cores3` を選択してください．

## ソースコードの編集

`src/main.cpp` を開いて，次の2個所を編集します．

- 13,14行目：WiFiアクセスポイントの設定
  - SSIDとPASSは当日に案内します．
  - 遠隔参加 or 自習されている方は，ご自身のPCと同じアクセスポイントの情報を記載してください．
- 19行目：Zenohエンドポイントの設定
  - ご自身のPCが接続されているIPv4アドレスを調べて `tcp/192.168.xx.yy:7447` のように記述してください．
  - IPアドレスの調べ方
    - [Windowsの例](https://support.microsoft.com/ja-jp/windows/f21a9bbc-c582-55cd-35e0-73431160a1b9)
    - [macOSの例](https://www.maclab.tokyo/random-note/settings/mac-ipaddress/8166/) または `ifconfig en0` など

## プロジェクトのビルド

最下部にある "PlatformIO Toolbar" の "Build" (レ点)をクリックするとプロジェクトをビルドできます．

"TERMINAL" に下記のようなメッセージが表示されればビルドが成功しています（Environmentの列が `m5stack-cores3` となっていて設定が正しいことを確認してください）．

```
Successfully created esp32s3 image.
========================================================== [SUCCESS] Took 21.23 seconds ==========================================================

Environment     Status    Duration
--------------  --------  ------------
m5stack-cores3  SUCCESS   00:00:21.231
========================================================== 1 succeeded in 00:00:21.231 ==========================================================
 *  Terminal will be reused by tasks, press any key to close it. 
```

## ボードへの書き込み

M5Stack CoreS3とPCをUSBケーブルで接続します．

最下部にある "PlatformIO Toolbar" の "Upload" (右矢印)をクリックするとボードへの書き込みが開始されます．

"TERMINAL" に下記のようなメッセージが表示されれば書き込みが成功しています．

```
Leaving...
Hard resetting via RTS pin...
============================================ [SUCCESS] Took 19.52 seconds ============================================

Environment     Status    Duration
--------------  --------  ------------
m5stack-cores3  SUCCESS   00:00:19.517
============================================ 1 succeeded in 00:00:19.517 ============================================
 *  Terminal will be reused by tasks, press any key to close it. 
```

M5のディスプレイにメッセージが表示されます．
ここでは，下記のメッセージが表示されていることを確認してください．特に`OK`が表示されていなければ，WiFiアクセスポイントに関するソースコードの編集を見直してください．

```
OK
Connecting to WiFi...
```

この時点では下記のメッセージが表示されますが，まだあわてる時間ではありません．

```
Unable to open session!
Opening Zenoh Session...
```

## Phoenixとの連携

先ほど動作させたPhoenixアプリと連携させましょう！

**ターミナル７**では，先ほどと同じくPhoenixアプリを実行します．

```bash
cd zenohex_phoenix_demo   # 必要であれば
mix phx.server
```

**ターミナル８**でZenohルータを起動させます．

```bash
zenohd
```

Webブラウザで http://localhost:4000 を開いてください．

M5Stack下部のリセットボタンを押してください．  
さてなにが起きるでしょう！信じるか信じないかは(ry

## 後始末

ハンズオンの終了時には，いずれかのターミナルで以下を実行してコンテナを終了しておきましょう．

```bash
exit   # コンテナから抜ける
docker compose down
```

おつかれさまでしたっ！Zenoh完全に理解したッ！！:D

# ハンズオン２：IoT的につなげる

組込みマイコン向けの[zenoh-pico](https://github.com/eclipse-zenoh/zenoh-pico)を用いて，前段のPhoenixアプリと繋げてみましょう！

## プロジェクトの設定

このリポジトリにある `zenoh_pico/` のディレクトリをVSCodeで開きます（File -> Open Folder... など）．
初回のオープン時にはプロジェクト設定が走りますので，ウインドウ下の "OUTPUT" に `Project has been sucessfully updated!` が表示されるまで待ちます．

最下部にある "PlatformIO Toolbar" だけで様々な操作が行えます．各ボタンの説明は下記をご参照ください．  
https://docs.platformio.org/en/latest/integration/ide/vscode.html#platformio-toolbar

最下部 "PlatformIO Toolbar" の "Project Environment Switcher" の表示が `Default (zenoh_pico)` となっていることを確認してください．

## ソースコードの編集

`src/main.cpp` を開いて，次の2個所を編集します．

- 13,14行目：WiFiアクセスポイントの設定
  - SSIDとPASSは会場では当日に案内します．
  - 遠隔参加or自習されている方は，ご自身のPCと同じアクセスポイントの情報を記載してください．
  - M5Stackマイコンボードの制約のため，2.4GHz帯で接続可能なSSIDを利用してください．5GHz帯では接続できません．可能であればバンドステアリング機能も無効化できるとよいです．
- 19行目：Zenohエンドポイントの設定
  - ご自身のPCが接続されているIPv4アドレスを調べて `tcp/192.168.xx.yy:7447` のように記述してください．
  - IPアドレスの調べ方
    - [Windowsの例](https://support.microsoft.com/ja-jp/windows/f21a9bbc-c582-55cd-35e0-73431160a1b9)
    - [macOSの例](https://www.maclab.tokyo/random-note/settings/mac-ipaddress/8166/) または `ifconfig en0` など

## プロジェクトのビルド

最下部にある "PlatformIO Toolbar" の "Build" (レ点)をクリックするとプロジェクトをビルドできます．

"TERMINAL" に下記のようなメッセージが表示されればビルドが成功しています．

```
Building .pio/build/m5stack-cores3/firmware.bin
esptool.py v4.5.1
Creating esp32s3 image...
Merged 2 ELF sections
Successfully created esp32s3 image.
================================================================ [SUCCESS] Took 22.17 seconds ================================================================
 *  Terminal will be reused by tasks, press any key to close it. 
```

このとき `UnknownBoard: Unknown board ID 'm5stack-cores3'` のエラーが出る場合は，プロジェクトの依存関係に問題がある可能性があります（[参考](https://qiita.com/tichise/items/54def94e70134742e73a)）．
"PlatformIO Toolbar" の "PlatformIO: New Terminal" をクリックしてターミナルを開き，そのターミナル上で `pio pkg update` のコマンドを実行して依存関係を更新してください．

## ボードへの書き込み

M5Stack CoreS3とPCをUSBケーブルで接続します．

最下部にある "PlatformIO Toolbar" の "Upload" (右矢印)をクリックするとボードへの書き込みが開始されます．

"TERMINAL" に下記のようなメッセージが表示されれば書き込みが成功しています．

```
Wrote 882416 bytes (570332 compressed) at 0x00010000 in 7.4 seconds (effective 956.2 kbit/s)...
Hash of data verified.

Leaving...
Hard resetting via RTS pin...
======================================================= [SUCCESS] Took 19.33 seconds =======================================================
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

M5Stack CoreS3の底面にあるリセットボタンを押してください．  
さてなにが起きるでしょう！信じるか信じないかは(ry

## 後始末

ハンズオンの終了時には，いずれかのターミナルで以下を実行してコンテナを終了しておきましょう．

```bash
exit   # コンテナから抜ける
docker compose down
```

おつかれさまでしたっ！Zenoh完全に理解したッ！！:D

## 補足など

- がむばれば他のM5ボードでもできますが `platform.ini` の記述がいろいろ必要なことがあります（[こんな感じ](https://github.com/takasehideki/zenoh_d3ai_trial/blob/main/zenoh_pico/platformio.ini)）
- zenohd (Zenoh router) は IP reachable であれば接続できます．でも今回はちょっとサボっています,,, ([こんな感じ](https://github.com/takasehideki/zenoh_swest26_trial/blob/main/docker-compose.yml#L8))
- がむばれば Cloud VM とも連携可能です（[こんな感じ](https://github.com/takasehideki/zenoh_d3ai_trial?tab=readme-ov-file#communication-with-cloud)）

# 環境準備

本リポジトリでは，SWEST26で実施するハンズオンの内容とその実施方法をまとめています．  

```
SWEST26
08/30(金) 13:50〜15:00 セッションs5b
「すべてが #Zenoh になる　〜柔軟にして軽量〜」 
```

- セッション情報： https://swest.toppers.jp/phx/event/program#s5b
- GitHubリポジトリ： https://github.com/takasehideki/zenoh_swest26_trial

本ファイルでは，ハンズオン内容を実施する環境の準備方法を示します．

## 必要なもの

- 開発用PC
  - CPU,OSは不問（のはず）
  - 5GB程度のディスク容量（Docker用）
  - Wi-Fi
  - USB Type-Aポート
    - Type-Cポートのみの場合はA-to-C変換アダプタをご用意ください
    - TypeC-TypeCケーブルがあればこれをご用意いただいても構いません
  - Webブラウザ
  - 次項で示す開発環境のインストール
- Wi-Fiアクセスポイントとインターネット接続環境　※
- [M5Stack CoreS3](https://docs.m5stack.com/ja/core/CoreS3)　※
- USB Type-Cケーブル　※

※はSWEST26現地参加者には貸出提供します．
オンライン参加or自習で進められる方はご自身でご用意ください．

Wi-Fiアクセスポイント（ルータ）は，2.4GHz帯で接続可能なものをご用意ください．
M5Stackマイコンボードの制約のため5GHz帯では接続できません．
可能であればバンドステアリング機能も無効化できるとよいです．

## 開発環境のインストール

必要なソフトウェアや開発環境の一覧を示します．

- ペイン分割できるターミナルアプリ（オススメ）
- Docker
- Visual Studio Code
- PlatformIO IDE for VSCode (extension)

以降，インストール方法などを具体的に説明していきます．

### ペイン分割できるターミナルアプリ

ハンズオンでは同時に複数のターミナルを立ち上げることになります．
このため，1画面でペイン分割できるアプリを使用することをオススメします．  
OSごとの代表的なアプリとインストール先・方法を示します．
もちろん他に使い慣れたものなどでも構いません．

- [Windows Terminal](https://learn.microsoft.com/ja-jp/windows/terminal/install)
- macOS: [iTerm2](https://iterm2.com/downloads.html)
- Linux: [Terminator](https://gnome-terminator.org/) (`sudo apt install terminator` など)

### Docker

ハンズオンの実行環境はDockerで提供しています．

まずはDocker Desktopのアプリケーションをインストールします．  
https://www.docker.com/ja-jp/products/docker-desktop/

CUI操作に慣れている方，有料サブスリプションの対象になる方は，[Docker Engine](https://docs.docker.com/engine/install/)を利用する選択肢もあります．

インストールできたら，ターミナルを開き，ビルド済みのDocker imageをpullします．

```bash
docker pull takasehideki/zenoh_swest26_trial
```

ビルド済みのDocker imageは下記で配布しています．  
https://hub.docker.com/r/takasehideki/zenoh_swest26_trial

Docker環境の詳細が気になる方は [docs/01docker.md](/docs/01docker.md) を参照してください．

### Visual Studio Code

特にハンズオン２でのIDEとしてVSCodeを用います．
下記からダウンロード・インストールしてください．  
https://code.visualstudio.com/download

### PlatformIO IDE for VSCode (extension)

組込みデバイスの開発環境には[PlatformIO](https://platformio.org/)を用います．
本ハンズオンでは，VSCodeの拡張機能（Extensions）を利用します．

VSCodeの「Extensions / 拡張機能」のウィンドウから「PlatformIO IDE」を検索してインストールしてください．
または，下記ページの「Install」をクリックしてインストールすることもできます．  
https://marketplace.visualstudio.com/items?itemName=platformio.platformio-ide

## [追加] 環境構築の確認

ここまでの手順が適切に完了しているかを確認する方法です．

### Docker環境

ターミナルを開いて下記を実行してください．

```bash
docker run -it --rm takasehideki/zenoh_swest26_trial /bin/bash
```

Dockerコンテナに入るはずです．
その先で下記のように実行して，適切なツールとバージョンが動作することを確認してください．

```bash
root@fa66be0acb79:/# rustc --version 
rustc 1.80.1 (3f5fd8dd4 2024-08-06)
root@fa66be0acb79:/# python3 --version 
Python 3.10.12
root@fa66be0acb79:/# elixirc --version 
Erlang/OTP 26 [erts-14.2.5.2] [source] [64-bit] [smp:10:10] [ds:10:10:10] [async-threads:1] [jit]

Elixir 1.16.3 (compiled with Erlang/OTP 26)
root@fa66be0acb79:/# zenohd --version 
2024-08-26T04:07:20.023319Z  INFO main ThreadId(01) zenohd: zenohd v0.11.0 built with rustc 1.72.0 (5680fa18f 2023-08-23)
zenohd v0.11.0 built with rustc 1.72.0 (5680fa18f 2023-08-23)
```

ちゃんといごいていたら `exit` でコンテナを終了してください．

### VSCode

VSCodeとPlatformIO IEDの拡張機能の動作確認を兼ねて，初期設定を行います．

下記リポジトリを `clone` してください．

```bash
git clone https://github.com/m5stack/CoreS3-UserDemo
```

clone してきた上記のディレクトリを VSCode で開いてください．
PCスペックや環境によっては相当の時間が掛かることがあるようです．

しばらく待って，VSCodeの最下部にある Status Bar に下記のような “PlatformIO Toolbar” が表示されていることを確認してください．  
https://docs.platformio.org/en/latest/integration/ide/vscode.html#platformio-toolbar


## ナビゲーション

- [ハンズオン１](/docs/1lang.md)に進む
- [目次](/README.md#目次)に戻る

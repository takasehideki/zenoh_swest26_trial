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


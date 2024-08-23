# zenoh_swest26_trial

本リポジトリでは，SWEST26で実施するハンズオンの内容とその実施方法をまとめています．  
https://swest.toppers.jp/phx/event/program#s5b
  
```
SWEST26
08/30(金) 13:50〜15:00 セッションs5b
「すべてが #Zenoh になる　〜柔軟にして軽量〜」 
```

## 目次

- [環境準備](/docs/00preliminary.md)
- [ハンズオン１：様々な言語でつなげる](/docs/1lang.md)
- [ハンズオン２：IoTにつなげる](/docs/2iot.md)

## 本環境の使用方法

ハンズオンの実行環境はDockerで提供しています．
Docker環境の詳細が気になる方は [docs/01docker.md](/docs/01docker.md) を参照してください．

### コンテナの起動と終了

複数のターミナルでコンテナに入ることになるので，バックグラウンドで起動することにします．

```bash
docker compose up -d
```

バックグラウンド起動されているコンテナを終了するには，次のコマンドを実行します．

```bash
docker compose down
```
### コンテナ内に入る

ハンズオンでは同時に複数のターミナルを立ち上げることになるので，1画面でペイン分割できるアプリを用いることをオススメします（Windows Terminal, iTerm2 (for macOS), Terminator (for Ubuntu)など）．

```bash
docker compose exec app bash
```

以降のコマンド例は，このコンテナ内で実行されることを想定しています．

## ハンズオン１：様々な言語で繋げる

Rust（[Zenohネイティブ実装](https://github.com/eclipse-zenoh/zenoh)），Python（[zenoh-python](https://github.com/eclipse-zenoh/zenoh-python)），Elixir（[Zenohex](https://github.com/biyooon-ex/zenohex)）でそれぞれ実装したZenohノードをPub/Subしてみます．

ターミナル（ペイン）は合計７個開いて，すべてのターミナルで `docker compose exec app bash` を実行してコンテナに入っておいてください．

### Rust版

#### ビルド

ターミナル１で実行します．

```bash
cd zenoh_native
cargo build
```

しばらく待って最後に以下のようなメッセージが表示されたら，ビルドに成功しています．

```
   Compiling zenoh_native v0.1.0 (/root/zenoh_swest26_trial/zenoh_native)
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 58.64s
```

#### Pubノードの実行

ターミナル１で実行します．

```bash
cd zenoh_native   # 必要であれば
./target/debug/pub
```

#### Subノードの実行

ターミナル２で実行します．

```bash
cd zenoh_native
./target/debug/sub
```

終了は`Ctrl+C`です．

### Python版

Pythonはビルド不要です，スクリプトだもの．

#### Pubノードの実行

ターミナル３で実行します．

```bash
cd zenoh_python
python3 pub.py
```

#### Subノードの実行

ターミナル４で実行します．

```bash
cd zenoh_native
python3 sub.py
```

終了は`Ctrl+C`です．

### Elixir版

#### ビルド

ターミナル５で実行します．

```bash
cd zenoh_elixir
mix deps.get
mix compile
```

しばらく待って最後に以下のようなメッセージが表示されたら，ビルドに成功しています．

```
==> zenoh_elixir
Compiling 3 files (.ex)
Generated zenoh_elixir app
```

#### Pubノードの実行

Elixir版ではIEx（専用のシェル）上で実行します．
以降の`iex()>`はIEx上での実行コマンドを表します．

ターミナル５で実行します．

```bash
cd zenoh_elixir   # 必要であれば
iex -S mix
iex()> ZenohElixir.Pub.main()
```

#### Subノードの実行

ターミナル６で実行します．

```bash
cd zenoh_elixir
iex -S mix
iex()> ZenohElixir.Sub.main()
```

IExを終了するには`Ctrl+C`を２回続けて入力してください．

### Phoenixとの連携

ZenohexのインストールされたPhoenixプロジェクトを実行し，各ノードのPub/Sub動作と連携させてみます．

#### リポジトリのcloneとビルド

Phoenix用のプロジェクトをcloneしてビルドします．
コンテナ内で行ってください．

```bash
cd <this_dir>
git clone -b swest26_demo https://github.com/biyooon-ex/zenohex_phoenix_demo
cd zenohex_phoenix_demo
mix setup
mix compile
```

しばらく待って最後に以下のようなメッセージが表示されたら，ビルドに成功しています．

```
Compiling 16 files (.ex)
Generated zenohex_phoenix_demo app
```

なお，本来はSubmodule化したほうが行儀も良いですが，作業ミスを防ぐためにこの方法としています．

### Phoenixアプリの立ち上げと動作確認

次のコマンドでPhoenixアプリを立ち上げます．

```bash
mix phx.server
```

Webブラウザで http://localhost:4000 を開いてください．

下段の「subscribe」フィールドには，Pubノードから出版されたメッセージの購読結果が出力されていきます．

上段の「Message:」フィールドに文字列を入力して「Publish」をクリックするとそれが出版されます．Subノードで購読できることを確認してみてください．

Phoenixアプリを終了するにはIEx上で`Ctrl+C`を２回続けて入力してください．

### 後始末

ここでハンズオンを終了する場合には，以下のコマンドでコンテナを終了しておきましょう（次のハンズオンにこのまま進む場合は実行する必要はありません）．

```bash
docker compose down
```

## ハンズオン２：組込みと繋げる

組込みマイコン向けの[zenoh-pico](https://github.com/eclipse-zenoh/zenoh-pico)を用いて，前段のPhoenixアプリと繋げてみましょう！

### プロジェクトの設定

このリポジトリにある `zenoh_pico/` のディレクトリをVSCodeで開きます（File -> Open Folder... など）．
初回のオープン時にはプロジェクト設定が走りますので，ウインドウ下の "OUTPUT" に `Project has been sucessfully updated!` が表示されるまで待ちます．

最下部にある "PlatformIO Toolbar" の "Project Environment Switcher" をクリックして， `env:m5stack-cores3` を選択してください．

IExを終了するには`Ctrl+C`を２回続けて入力してください．

### ソースコードの編集

`src/main.cpp` を開いて，次の2個所を編集します．

- 13,14行目：WiFiアクセスポイントの設定
  - SSIDとPASSは当日に案内します．
  - 遠隔参加 or 自習されている方は，ご自身のPCと同じアクセスポイントの情報を記載してください．
- 19行目：Zenohエンドポイントの設定
  - ご自身のPCが接続されているIPv4アドレスを調べて `tcp/192.168.xx.yy:7447` のように記述してください．
  - IPアドレスの調べ方
    - [Windowsの例](https://support.microsoft.com/ja-jp/windows/f21a9bbc-c582-55cd-35e0-73431160a1b9)
    - [macOSの例](https://www.maclab.tokyo/random-note/settings/mac-ipaddress/8166/) または `ifconfig en0` など

### プロジェクトのビルド

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

### ボードへの書き込み

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

### Phoenixとの連携

先ほど動作させたPhoenixアプリと連携させましょう！

ターミナル（ペイン）は２個開いて，それぞれのターミナルで `docker compose exec app bash` を実行してコンテナに入っておいてください．

ターミナル１では，Zenohルータを起動させます．

```bash
zenohd
```

ターミナル２ではPhoenixアプリを実行します．

```bash
cd zenohex_phoenix_demo
mix phx.server
```

Webブラウザで http://localhost:4000 を開いてください．

M5Stack下部のリセットボタンを押してください．  
さてなにが起きるでしょう！信じるか信じないかは(ry

### 後始末

ハンズオンの終了時には，以下のコマンドでコンテナを終了しておきましょう（次のハンズオンにこのまま進む場合は実行する必要はありません）．

```bash
docker compose down
```

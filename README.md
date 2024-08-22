# zenoh_swest26_trial

SWEST26で実施するハンズオンの進め方をまとめています．  
https://swest.toppers.jp/phx/event/program#s5b
  
```
SWEST26
08/30(金) 13:50〜15:00 セッションs5b
「すべてが #Zenoh になる　〜柔軟にして軽量〜」 
```

## 本環境の使用方法

ハンズオンの実行環境はDockerで提供しています．
Docker環境の詳細が気になる方は [docker/](/docker/) を参照してください．

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

ターミナル（ペイン）は合計７個立ち上げてください．

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

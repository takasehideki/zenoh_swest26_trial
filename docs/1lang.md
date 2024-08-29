## ハンズオン１：様々な言語でつなげる

Rust（[Zenohネイティブ実装](https://github.com/eclipse-zenoh/zenoh)），Python（[zenoh-python](https://github.com/eclipse-zenoh/zenoh-python)），Elixir（[Zenohex](https://github.com/biyooon-ex/zenohex)）でそれぞれ実装したZenohノードを通信させてみます．

## 準備

このGitHubリポジトリをcloneします．
submoduleを含んでいるので `--recursive` を付け忘れないようにしてください．

```bash
git clone --recursive https://github.com/takasehideki/zenoh_swest26_trial
```

以降の説明では，cloneしてきた本リポジトリをトップディレクトリとして記載します．

ターミナル（ペイン）は合計８個開きます．４行２列にすると使いやすいでしょう．  
Windows Terminalの場合は，`Alt+Shift++`で垂直方向に，`Alt+Shift+-`で水平方向にペインを作成できます（[参考](https://learn.microsoft.com/ja-jp/windows/terminal/panes)）．
macOSのiTermやLinuxのTerminatorでは，ターミナル上で右クリックすると分割のためのメニューが選択できます．  
以降，対象のターミナルを「**ターミナル１**」のように記載します．

まずはDockerコンテナを起動します．
８個のターミナル全てでコンテナに入るようにするので，バックグラウンドで起動させます．

**ターミナル１**で次のコマンドを実行してください．

```bash
cd zenoh_swest26_trial
docker compose up -d
```

次に，８個の全てのターミナルでコンテナに入ります．

```bash
cd zenoh_swest26_trial
docker compose exec app bash
```

以降の説明は，このコンテナ内で実行されることを想定しています．

## ノードのビルド

まずはそれぞれのノードをビルドしていきます．

Pythonはビルド不要です，スクリプトだもの．

**ターミナル３**でElixirのノードをビルドします．

```bash
cd zenoh_elixir
mix deps.get
mix compile
```

少し待って最後に以下のようなメッセージが表示されたら，ビルドに成功しています．

```
==> zenoh_elixir
Compiling 3 files (.ex)
Generated zenoh_elixir app
```

**ターミナル５**でRustのノードをビルドします．

```bash
cd zenoh_native
cargo build
```

PCスペックによってはRustのビルドに相当の時間が掛かることがあります．
その場合にはビルドはそのまま止めずに次のステップに進んでください．

しばらく待って最後に以下のようなメッセージが表示されたら，ビルドに成功しています．

```
   Compiling zenoh_native v0.1.0 (/root/zenoh_swest26_trial/zenoh_native)
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 58.64s
```

## ノードの実行

### 購読ノード

まずは購読ノードを実行していきます．

**ターミナル１**でPythonのノードを実行します．

```bash
cd zenoh_python
python3 sub.py
```

ElixirはIEx（専用のシェル）上で実行します．
以降の`iex()>`はIEx上での実行コマンドを表します．

**ターミナル３**でElixirのノードを実行します．

```bash
iex -S mix
iex()> ZenohElixir.Sub.main()
```

**ターミナル５**で（ビルドが完了していたら）Rustのノードを実行します．

```bash
./target/debug/sub
```

### 出版ノード

次に出版ノードを実行していきます．

**ターミナル２**でPythonのノードを実行します．

```bash
cd zenoh_python
python3 pub.py
```

**ターミナル４**でElixirのノードをIEx上で実行します．

```bash
cd zenoh_elixir
iex -S mix
iex()> ZenohElixir.Pub.main()
```

**ターミナル６**で（ビルドが完了していたら）Rustのノードを実行します．

```bash
./target/debug/pub
```

さてどうでしょうか？うまくいごいているでしょうか？？

## Phoenixとの連携

ノードは動かし続けたままで，ちょっとIoTっぽくWeb連携させてみましょう．

Zenohexを用いたPhoenixプロジェクトを実行し，各ノードとPub/Sub通信させてみます．

**ターミナル７**でPhoenix用のプロジェクトをビルドします．

```bash
cd zenohex_phoenix_demo
mix setup
mix compile
```

しばらく待って最後に以下のようなメッセージが表示されたら，ビルドに成功しています．

```
Compiling 16 files (.ex)
Generated zenohex_phoenix_demo app
```

このまま**ターミナル７**でPhoenixアプリを立ち上げます．

```bash
mix phx.server
```

Webブラウザで http://localhost:4000 を開いてください．  
出版購読のノードを終了させていた方は，改めて実行し直してください．

下段の「subscribe」フィールドには，Pubノードから出版されたメッセージの購読結果が出力されていきます．

上段の「Message:」フィールドに文字列を入力して「Publish」をクリックするとそれが出版されます．Subノードで購読できることを確認してみてください．

## 終了方法

ここまでのアプリをいったん終了させておきましょう．

PythonとRustのノードの終了は`Ctrl+C`です．  
ElixirのノードとPhoenixアプリを終了するには，IEx上で`Ctrl+C`を２回続けて入力します．

Dockerコンテナは終了させる必要はありません．

## ナビゲーション

- [ハンズオン２](/docs/2iot.md)に進む
- [目次](/README.md#目次)に戻る

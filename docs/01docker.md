# Docker環境について

本ハンズオンのために用意したDocker環境についてまとめています．

ビルド済みのDocker imageは下記で配布しています．  
https://hub.docker.com/r/takasehideki/zenoh_swest26_trial

## インストールされているツールとバージョン

- base image: [hexpm/elixir:1.16.3-erlang-26.2.5.2-ubuntu-jammy-20240808](https://hub.docker.com/layers/hexpm/elixir/1.16.3-erlang-26.2.5.2-ubuntu-jammy-20240808/images/sha256-9b6fbcf459a054df2258f5cd5b7c5ed4b7bc40cc0b690b77409768bac69f413c?context=explore)
  - Ubuntu 22.04
  - Elixir 1.16.3-otp-26
  - Erlang 26.2.5
- Zenoh 0.11.0
- Rust 1.80.1
- Python 3.10.12

## 自前でのビルド方法

```bash
cd docker
docker build -t takasehideki/zenoh_swest26_trial .
```

## MEMO for ME: multi-platform build と Docker Hubへのpush

M1Macで実行しています．

```bash
cd docker
docker buildx create --name mybuilder
docker buildx use mybuilder
docker buildx build --platform linux/amd64,linux/arm64 -t takasehideki/zenoh_swest26_trial . --push
```

## ナビゲーション

- [ハンズオン１](/docs/1lang.md)に進む
- [環境準備](/docs/00preliminary.md)に戻る
- [目次](/README.md#目次)に戻る

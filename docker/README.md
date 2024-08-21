# Docker環境について

本ハンズオンのために用意したDocker環境についてまとめています．

ビルド済みのDocker imageは下記で配布しています．  
https://hub.docker.com/repository/docker/takasehideki/zenoh_swest26_trial

## インストールされているツールとバージョン

- Ubuntu 22.04 (base image)
- Zenoh 0.11.0
- Rust 1.80.1
- Python 3.10.12
- ASDF v0.14.0
- Erlang 26.2.5
- Elixir 1.16.3-otp-26

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

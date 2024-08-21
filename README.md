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

### コンテナの起動

複数のターミナルでコンテナに入ることになるので，バックグラウンドで起動することにします．

```
docker compose up -d
```

### コンテナ内に入る

```
docker compose exec app bash
```

### コンテナの終了

```
docker compose down
```

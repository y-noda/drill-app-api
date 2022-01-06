# drill-app-api

## ローカル環境構築

### 立ち上げ
・　docker と docker-composeをinstallした状態で下記コマンド
docker-compose　up -d

http://localhost:1080/

### とめる

①　動いているコンテナ一覧表示
docker ps

② 動いているコンテナ　をとめる
docker stop <コンテナのid> ...


## mongoDBのリセット (参考　https://qiita.com/k-staging/items/a386d272abb2c9b92f1a）

① mongoDBのコンテナに入る
docker-compose exec mongo bash

② mongodbにログイン
mongo

③ DB表示 
show dbs;

④ DB選択
use api-development;

⑤ コレクション表示
show collections;

⑥ コレクション削除
db.<コレクション名>.drop()

## mongoDBのGUI操作（ローカル開発環境)
http://localhost:27017/

## ユーザテストデータ作成
rails r db/mongo_seed/user_seeder.rb


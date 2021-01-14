# ①アプリケーションについて
## URL
URL:  https://self-mba.org/
github: https://github.com/shu1124/webapp
## 概要
- アプリケーション名:「SELF MBA」
- 内容：経営学の学習を記録し、勉強仲間と交流するためのアプリケーション
- 作成理由：昔から勉強や本を読むのが好きで、特に大学時代から学んでいる経営学の学習を記録したり、同じジャンルを学んでいる人と交流したいと思ったから。



# ②アプリケーションの詳細について
## 機能
- ログイン機能(jwt)
- 学習の内容・時間の投稿機能(CRUD),modalによる投稿画面
- ページネーション機能(kaminari)
- アバター, 投稿の画像保存機能(activestorage)
- タグ機能
- タグ検索機能
- 投稿へのいいね機能
- フォロー,フォロワー機能
- コメント機能

## 使用技術
- フロントエンド：vue.js(webpackerによる管理), vuetify, vuex, vue-router
- バックエンド: Ruby on Rails(api)
- インフラ: AWS(ECS,ECR,VPC,ROUTE53,ACM,RDS), Docker, docker-compose, CircleCI, terraform(調整中)




# ③補足
## データベース
![database](https://user-images.githubusercontent.com/64460231/104606763-7109a100-56c3-11eb-8041-868bc221a0c1.png)
## インフラ構成図
![AWS (2019年) フレームワーク](https://user-images.githubusercontent.com/64460231/104606977-ad3d0180-56c3-11eb-81f5-b820def59af3.png)



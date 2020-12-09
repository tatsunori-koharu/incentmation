## テーブル設計

## users テーブル

| Column               | Type    | Options                   |
| -------------------- | ------- | ------------------------- |
| nickname             | string  | null: false, unique: true |
| email                | string  | null: false, unique: true |
| encrypted_password   | string  | null: false               |
| location_id          | integer | null: false               |
| department_id        | string  | null: false               |
| bed                  | integer |                           |
| service_years        | integer | null; false               |
| license              | string  |                           |
| company              | string  |                           |

## Association

- has_many :articles
- has_many :article_comments
- has_many :article_likes
- has_many :consultations
- has_many :consultation_comments
- has_many :consultation_fixes
- has_many :promotions
- has_many :promotion_comments
- has_many :promotion_likes
- has_many :chats, through: :user_chats
- has_many :user_chats
- has_many :chat_messages
- has_many :donkeykings

## articles テーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| title                | string     | null: false                    |
| content              | text       | null: false                    |
| category_id          | integer    | null: false                    |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs_to :user
- has_many   :article_comments
- has_many   :article_likes

## article_commentテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| comment              | text       | null: false                    |
| article              | references | null: false, foreign_key: true |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs :article
- belongs :user

## article_likesテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| article              | references | null: false, foreign_key: true |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs :article
- belongs :user

## consultationテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| title                | string     | null: false                    |
| content              | text       | null: false                    |
| category_id          | integer    | null: false                    |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs_to :user
- has_many   :consultation_comments
- has/many   :consultation_fixes

## consultation_commentsテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| comment              | text       | null: false                    |
| consultation         | references | null: false, foreign_key: true |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs_to :user
- belongs_to :consultation

## consultation_fixesテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| consultation         | references | null: false, foreign_key: true |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs :consultation
- belongs :user

## promotionテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| name                 | string     | null: false                    |
| content              | text       | null: false                    |
| category_id          | integer    | null: false                    |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs_to :user
- has_many   :promotion_comments
- has_many   :promotion_likes

## promotion_commentsテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| comment              | text       | null: false                    |
| promotion            | references | null: false, foreign_key: true |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs_to :user
- belongs_to :promotion

## promotion_likesテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| promotion            | references | null: false, foreign_key: true |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs :promotion
- belongs :user

## chatテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |

## Association

- has_many :user_chats
- has_many :users, through: :user_chats
- has_may  :chat_messages

## user_chatsテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| chat                 | references | null: false, foreign_key: true |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs :chat
- belongs :user

## chat_messagesテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| message              | string     | null: false                    |
| chat                 | references | null: false, foreign_key: true |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs_to :user
- belongs_to :chat

## donkeykingsテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| content              | string     | null: false                    |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs_to :user

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>


## アプリケーション名  
# incentmation(インセントメーション)  

## アプリケーションの概要
`incentmationはinformation(情報)とconcentration(集中する)を合わせた造語の意味通り、情報を集中させるサイトを目指しています。<br/>特に、ニッチな業界では情報の統制が行われていない事が多く、知りたい事を探すだけでしんどい思いをする事が多くあります。<br/>
そこで、個々の問題をみんなで解決できる場所を提供し早期の問題解決のいとぐちになればと考えています。<br/>
アプリ内では、主にトピックス、相談、商品紹介を基本としており、各個人が様々な情報の発信が行える他、現場で困っている事を投稿し、同じ事を解決したことのある人などから様々な解決方法を獲得し自身の現場にフィードバックしていけるようにします。そして、商品紹介ですが、様々な状況に直面した事があるであろう、その業界に特化した商品を販売している企業がこのサイトに参加することにより、よりたくさんの情報が落とし込まれる事を期待しています。商品紹介はその問題解決の一役を担うものをスムーズに紹介できる場となると考えています。<br/>
また、個人間で行える会話スペースを取り入れる事でより密な情報収集ができると考えています｀
<br/>
<br/>
***

## アプリケーションURL:<br/>
 52.198.163.101
<br/>
***

## Basic認証<br/>
ID : koharu <br/>
password :0930<br/>
***

## テスト用アカウント<br/>
Email: koharu0930@gmail.com<br/>
password: 999999<br/>
***

## 利用方法<br/>
* WebブラウザGoogle Chromeの最新版を利用してアクセスしてください。<br/>
  * ただしデプロイ等で接続できないタイミングもございます。その際は少し時間をおいてから接続してください。<br/>
* 接続先およびログイン情報については、上記の通りです。<br/>
* 同時に複数の方がログインしている場合に、ログインできない可能性があります。<br/>
* テストアカウントでログイン→トップページからトピックス→情報投稿→投稿ページ記入（画像・動画は無くても可）→情報投稿<br/>
  * 相談、商品紹介も同様<br/>
* テストアカウントでログイン→トップページからチャット→相手選択→チャットルームでチャット開始。あるいは、トピックス投稿等にある個人名を選択→個人詳細表示→チャット選択→チャット開始<br/>
* テストアカウントでログイン→トップページから愚痴→愚痴投稿 <br/>
***

## 目指した課題解決
* 閉鎖された業界での情報共有<br/>
  * 業界で起こっている様々な変化へ素早くキャッチアップできるように、一つのサイトで情報が網羅できる<br/>
* 早期の問題解決
  * 1人で悩まずに横の繋がりで問題を解決していく。そこで起こった問題は別の場所でも起こっている可能性を考え、幅広い方へ相談し問題解決を行う<br/>
* 便利な商品の紹介<br/>
  * 問題解決に向けて、便利になりうる商品を紹介し道具で早期の問題解決へつなげる<br/>
  * 多くの情報を持っているであろう企業がサイトに参加することにより情報の活発化を狙う<br/>
* ストレス発散<br/>
  * 日々過酷な業務に追われる中で蓄積するであろうストレスを言葉にできるスペースを提供。投稿したコメントは1時間で削除されるため、安心して投稿できる<br/>
***

## 洗い出した要件<br/>
* 情報が整理されている（カテゴライズ）<br/>
* 個人の見解が見れる（コメント機能）<br/>
* 意見の交換（チャット（グループ・個人））<br/>
* 相談フォーム（コメント機能・画像・動画）<br/>
* 情報が見やすい（画像・動画・検索）<br/>
* 企業も情報を持っているので、宣伝含めコミュニティーへの参加（宣伝フォーム）<br/>
* 情報の流出を抑えるためメンバー制（ログイン）<br/>
* 愚痴を言える場所（１時間前後で自動削除機能）<br/>
***

## 実装した機能<br/>
* ユーザー管理機能
  * 新規登録機能<br/>
    * 新規登録をemail・SNSアカウントで行える<br>
    <a href="https://gyazo.com/058b61ba31986b14d0d65f80e9913c80"><img src="https://i.gyazo.com/058b61ba31986b14d0d65f80e9913c80.gif" alt="Image from Gyazo" width="1000"/></a><br/>
  * ログイン機能<br/>
    * email・SNSアカウントで行える<br/>
    <a href="https://gyazo.com/c52137e3437059a0291085ac84eaa38d"><img src="https://i.gyazo.com/c52137e3437059a0291085ac84eaa38d.gif" alt="Image from Gyazo" width="910"/></a><br/>
  * 個人詳細機能表示<br/>
    * 個人の詳細情報を閲覧できる。また、どのような投稿をしたかも確認できる<br>
***
## 実装予定の機能<br/>
* カテゴリー選別機能<br/>
* 検索機能<br/>
* グループチャット機能<br/>
***

## ER図<br/>
[![Image from Gyazo](https://i.gyazo.com/f12adacd0ecc2b9ee64595e8c236d7b4.png)](https://gyazo.com/f12adacd0ecc2b9ee64595e8c236d7b4)<br/>
***

## ローカルでの動作方法<br/>
```
% git clone https://github.com/tatsunori-koharu/incentmation.git
% cd incentmation
% bundle install
% yarn install 
% rails db:create
% rails db:migrate
% rails s
```
<br/>
制作環境<br/>
ruby: 2.6.5<br/>
rails:6.0.3.4<br/>


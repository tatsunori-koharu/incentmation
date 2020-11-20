## テーブル設計

## users テーブル

| Column               | Type    | Options                   |
| -------------------- | ------- | ------------------------- |
| nickname             | string  | null: false, unique: true |
| email                | string  | null: false, unique: true |
| encrypted_password   | string  | null: false               |
| location_id          | integer | null: false               |
| department_id        | string  | null: false               |
| bed                  | integer | null: false               |
| service_years        | integer | null; false               |
| license              | string  |                           |
| company              | string  |                           |

## Association

- has_many :articles
- has_many :article_comments
- has_many :consultations
- has_many :consultation_comments
- has_many :promotions
- has_many :promotion_comments
- has_many :chats
- has_many :tweets

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

## article_commentテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| comment              | text       | null: false                    |
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

## consultation_commentsテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| comment              | text       | null: false                    |
| consultation         | references | null: false, foreign_key: true |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs_to :user
- belongs_to :consultation

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

## promotion_commentsテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| comment              | text       | null: false                    |
| promotion            | references | null: false, foreign_key: true |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs_to :user
- belongs_to :promotion

## chatテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| comment              | string     | null: false                    |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs_to :user

## tweetテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| content              | string     | null: false                    |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs_to :user
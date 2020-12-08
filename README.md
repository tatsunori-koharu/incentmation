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

## tweetテーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| content              | string     | null: false                    |
| user                 | references | null: false, foreign_key: true |

## Association

- belongs_to :user
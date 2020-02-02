# README
# Chat-Space DB設計

## usersテーブル
|Column|type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|password|string|null: false|

### Association
-has_many: comments
-has_many: groups_users
-has_many: groups, through: :groups_users


## groupsテーブル
|Column|type|Options|
|------|----|-------|
|name|string|null: false|

### Association
-has_many: groups_users
-has_many: comments
-has_many: users, through: :groups_users


## groups_usersテーブル
|Column|type|Options|
|------|----|-------|
|group|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association
-belongs_to: group
-belongs_to: user


## Commentsテーブル
|Column|type|Options|
|------|----|-------|
|body|text|
|image|string|
|user|references|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
-belongs_to: user
-belongs_to: group




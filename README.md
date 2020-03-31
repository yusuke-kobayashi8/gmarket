# README

*## Usresテーブル*
|Column|Type|Options|
|———|——|———|
|nickname|string|null: false, unique: true|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|integer|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|postal_code|inetger|null: false|
|prefectures|string|null: false|
|city|string|null: false|
|adress|string|null: false|
|building|string|
|posting_family_name|string|null: false|
|posting_first_name|string|null: false|
|posting_family_name_f|string|null: false|
|posting_first_name_f|string|null: false|
|telephone|integer|
*### Association*
- belongs_to :credit_card
- has_many :products

*### Productsテーブル*
|Column|Type|Options|
|———|——|———|
|product_name|string|null: false|
|price|integer|null: false|
|detail|text|null: false|
|status|text|null: false|
|derivery-fee|string|null: false|
|derivery-days|string|null: false|
|place|string|null: false|
|user_id|references|null: false, foreign_key: true|
|brand_id|

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

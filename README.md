# README

## Usresテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|integer|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
### Association
- has_one :address
- has_one :credit_card
- has_many :orders
- has_many :products

## Productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|detail|text|null: false|
|status|text|null: false|
|derivery_fee|string|null: false|
|derivery_days|string|null: false|
|place|string|null: false|
|user|references|null: false, foreign_key: true|
|brand|references|foreign_key: true|
|category|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- has_one :order
- has_many :images
- belongs_to :category
- belongs_to :brand

## Credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|customer|integer|null: false, foreign_key: true|
|card|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## Ordersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|foreign_key: true|
|product_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :product

## Imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|product|references|null: false, foreign_key: true|
### Association
- belongs_to :product

## Ctegoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||
### Association
- has_many :products
- has_ancestry

## Brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :products

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
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
|user_id|references|foreign_key: true|
### Association
- belongs_to :user

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

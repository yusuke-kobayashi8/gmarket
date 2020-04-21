require 'faker'

FactoryBot.define do

  # 画像が1枚の時
  factory :product do
    
    user_id          {1}
    name             {Faker::Games::Zelda.item}
    price            {Faker::Number.within(range: 300..9999999)}
    detail           {Faker::Books::Dune.quote}
    status_id        {1}
    delivery_cost_id {1}
    days_to_ship_id  {1}
    prefecture_id    {27}
    category_id      {708}
    brand_id         {4}
    after(:build) do |product|
      product.images << build(:image, product: product)
    end

    association :user
    association :category
  end

  # 画像が複数の時
  factory :product_multipul_images, class: Product do
    user_id          {1}
    name             {Faker::Games::Zelda.item}
    price            {Faker::Number.within(range: 300..9999999)}
    detail           {Faker::Books::Dune.quote}
    status_id        {1}
    delivery_cost_id {1}
    days_to_ship_id  {1}
    prefecture_id    {27}
    category_id      {708}
    brand_id         {4}
    after(:build) do |product|
      # build_listでimageを２回生成
      product.images << build_list(:image, 2, product: product)
    end

    association :user
    association :category
  end

  # 画像がない時
  factory :product_without_images, class: Product do
    user_id          {1}
    name             {Faker::Games::Zelda.item}
    price            {Faker::Number.within(range: 300..9999999)}
    detail           {Faker::Books::Dune.quote}
    status_id        {1}
    delivery_cost_id {1}
    days_to_ship_id  {1}
    prefecture_id    {27}
    category_id      {708}
    brand_id         {4}

    association :user
    association :category
  end
end
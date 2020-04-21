FactoryBot.define do

  factory :product do
    name             {""}
    price            {""}
    detail           {""}
    status_id        {""}
    delivery_cost_id {""}
    days_to_ship_id  {""}
    prefecture_id    {""}

    after(:build) do |product|
      product.images << build(:image, product: product)
    end
  end
end
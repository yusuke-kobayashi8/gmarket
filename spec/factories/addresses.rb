require 'faker'
FactoryBot.define do

  factory :address do
    postal_code {1234567}
    prefecture_id {1}
    city {"大阪市"}
    address {"中央区"}
    # building {Faker::Address.building_number}
    posting_family_name {"鈴木"}
    posting_first_name {"太郎"}
    posting_family_name_f {"スズキ"}
    posting_first_name_f {"タロウ"}
  end

end
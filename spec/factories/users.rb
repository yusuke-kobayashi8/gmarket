require 'faker'
FactoryBot.define do

  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 7)
    password {password}
    password_confirmation {password}
    family_name {Faker::Name.last_name}
    first_name {Faker::Name.last_name}
    family_name_kana {"ヤマダ"}
    first_name_kana {"タロウ"}
    birthday {Faker::Date.birthday}
  end

end
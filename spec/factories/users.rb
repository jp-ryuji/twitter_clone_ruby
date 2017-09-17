FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Crypto.sha1 }
  end
end

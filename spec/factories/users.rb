FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Crypto.sha1 }
    screen_name { Faker::Twitter.screen_name[0..14] } # The method can return a word with more than 15 chars.
  end
end

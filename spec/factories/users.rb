# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Crypto.sha1 }
    screen_name { Faker::Twitter.screen_name[0..14] } # The method can return a word with more than 15 chars.

    transient do
      posts_count 0
    end

    after(:create) do |user, evaluator|
      create_list(:post, evaluator.posts_count, user: user) if evaluator.posts_count.positive?
    end
  end
end

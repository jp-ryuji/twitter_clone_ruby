# frozen_string_literal: true

FactoryGirl.define do
  factory :post do
    user
    content { Faker::Lorem.sentence(10) }
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  id_token   :string           not null
#
# Indexes
#
#  index_posts_on_id_token  (id_token) UNIQUE
#  index_posts_on_user_id   (user_id)
#

FactoryBot.define do
  factory :post do
    user
    content { Faker::Lorem.sentence(10) }
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
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
    content { Faker::Lorem.sentence }
  end
end

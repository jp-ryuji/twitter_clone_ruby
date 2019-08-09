# frozen_string_literal: true
# == Schema Information
#
# Table name: posts
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
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

class PostSerializer < ActiveModel::Serializer
  attributes :content

  belongs_to :user
end

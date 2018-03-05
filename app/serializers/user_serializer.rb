# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :email, :screen_name

  has_many :posts
end

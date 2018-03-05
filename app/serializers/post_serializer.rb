# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :content

  belongs_to :user
end

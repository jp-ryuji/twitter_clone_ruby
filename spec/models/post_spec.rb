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

require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'has id_token' do
    # NOTE: Returns a Post instance that's not saved.
    post = build(:post)
    expect(post.id_token).to be_nil
    # NOTE: Use save! instead of save in specs to raise an exception when there is.
    #   You might need to post.reload sometimes in specs although this is not the case here.
    post.save!
    expect(post.id_token).to be_present
  end
end

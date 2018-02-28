# frozen_string_literal: true

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

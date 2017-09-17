require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it 'has many followers' do
    user.followers << create_list(:user, 2)
    expect(user.followers.size).to eq(2)
  end

  it 'has many followees' do
    create_list(:user, 2).each { |u| u.followers << user }
    expect(user.followees.size).to eq(2)
  end

  describe '#follow, #unfollow, #following?' do
    it 'enables to follow' do
      follower = create(:user)
      expect(follower.following?(user)).to be_falsey

      follower.follow(user)
      expect(follower.followees.size).to eq(1)
      expect(follower.following?(user)).to be_truthy

      follower.unfollow(user)
      expect(follower.followees.size).to eq(0)
      expect(follower.following?(user)).to be_falsey
    end
  end
end

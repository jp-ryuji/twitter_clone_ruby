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

  describe 'validations' do
    describe 'email' do
      it 'is present' do
        user = build(:user, email: nil)
        expect(user).to be_invalid
        expect(user.errors[:email]).to include("can't be blank")

        user = build(:user, email: '')
        expect(user).to be_invalid
        expect(user.errors[:email]).to include("can't be blank")
      end

      it 'does not allow invalid format' do
        invalid_email_formats = %w(
          user@example,com
          user_at_foo.org
          user.name@example.
          foo@bar_baz.com
          foo@bar..com
        )

        invalid_email_formats.each do |email|
          user = build(:user, email: email)
          expect(user).to be_invalid
          expect(user.errors[:email]).to include('is invalid')
        end
      end

      it 'allows valid format' do
        user = build(:user, email: 'text@example.com')
        expect(user).to be_valid
      end
    end
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

    it 'disallows to follow myself' do
      expect { user.follow(user) }.to raise_error
      expect(user.followers.size).to eq(0)
    end
  end
end

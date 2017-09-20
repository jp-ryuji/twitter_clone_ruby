require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it 'has many followers' do
    user.followers << create_list(:user, 2)
    expect(user.followers.size).to eq(2)
  end

  it 'has many following users' do
    create_list(:user, 2).each { |u| u.followers << user }
    expect(user.following_users.size).to eq(2)
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

      it 'is case insensitive' do
        email = 'Test@EXAMPLE.COM'
        create(:user, email: email)
        expect { create(:user, email: email.downcase) }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'is saved in lowercase letters' do
        email = 'Test@EXAMPLE.COM'
        create(:user, email: email)
        expect(User.find_by(email: email.downcase)).to be_truthy
      end
    end

    describe 'password' do
      it 'is present' do
        user = build(:user, password: nil)
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("can't be blank")

        user = build(:user, password: '')
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("can't be blank")
      end

      it 'is more than 5 characters' do
        user = build(:user, password: 'aaaaa')
        expect(user).to be_invalid
        expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')

        user = build(:user, password: 'aaaaaa')
        expect(user).to be_valid
      end
    end

    describe 'screen_name' do
      it 'is present' do
        user = build(:user, screen_name: nil)
        expect(user).to be_invalid
        expect(user.errors[:screen_name]).to include("can't be blank")

        user = build(:user, screen_name: '')
        expect(user).to be_invalid
        expect(user.errors[:screen_name]).to include("can't be blank")
      end

      it 'is equal to or less than 15 characters' do
        user = build(:user, screen_name: 'a' * 16)
        expect(user).to be_invalid
        expect(user.errors[:screen_name]).to include('is invalid')

        user = build(:user, screen_name: 'a' * 15)
        expect(user).to be_valid
      end

      it 'consists of alphanumeric characters and underscores only' do
        user = build(:user, screen_name: 'aあ')
        expect(user).to be_invalid
        expect(user.errors[:screen_name]).to include('is invalid')

        user = build(:user, screen_name: 'abc_123')
        expect(user).to be_valid
      end

      it 'is not included in UNAVAILABLE_SCREEN_NAMES' do
        UNAVAILABLE_SCREEN_NAMES[0..5].each do |screen_name|
          user = build(:user, screen_name: screen_name)
          expect(user).to be_invalid
          expect(user.errors[:screen_name]).to include('is reserved')
        end
      end
    end

    describe 'name' do
      it 'is equal to or less than 20 characters' do
        user = build(:user, name: 'a' * 21)
        expect(user).to be_invalid
        expect(user.errors[:name]).to include('is too long (maximum is 20 characters)')

        user = build(:user, name: 'a' * 20)
        expect(user).to be_valid
      end
    end
  end

  describe '#follow, #unfollow' do
    it 'enables to follow' do
      follower = create(:user)

      follower.follow(user)
      expect(follower.following_users.size).to eq(1)

      follower.unfollow(user)
      expect(follower.following_users.size).to eq(0)
    end

    it 'disallows to follow myself' do
      expect { user.follow(user) }.to raise_error(ActiveRecord::RecordInvalid)
      expect(user.followers.size).to eq(0)
    end
  end
end

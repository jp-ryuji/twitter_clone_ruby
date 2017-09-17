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
end

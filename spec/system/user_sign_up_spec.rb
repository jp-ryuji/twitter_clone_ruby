# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User sign up', type: :system do
  it 'proceeds to sign up', js: true do
    visit root_path

    click_on 'Sign up'
    expect(page).to have_current_path(signup_path) # NOTE: This is an example. You don't always need to check the current_path.

    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_screen_name', with: 'test'
    fill_in 'user_password', with: 'password'
    click_on 'Sign up'
    expect(page).to have_content('Signed up')
  end
end

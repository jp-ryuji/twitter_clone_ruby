# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each) do |example|
    if example.metadata[:type] == :system
      # NOTE: See more https://medium.com/table-xi/a-quick-guide-to-rails-system-tests-in-rspec-b6e9e8a8b5f6
      if ENV['CHROME']
        driven_by :selenium_chrome, screen_size: [1400, 1400]
      elsif example.metadata[:js]
        driven_by :selenium_chrome_headless, screen_size: [1400, 1400]
      else
        # NOTE: rack_test doesn't support JavaScript.
        driven_by :rack_test
      end
    end
  end
end

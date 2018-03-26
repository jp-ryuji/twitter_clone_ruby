# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.0'

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 1.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'dotenv-rails'
gem 'virtus'
gem 'kaminari'
gem 'bootstrap4-kaminari-views'
gem 'webpacker'

# Authentication
# NOTE: devise is more widely used and you should use it instead of sorcery.
gem 'sorcery'

# View
# FIXME: JS libraries should be loaded with yarn.
gem 'jquery-rails'
gem 'popper_js'
gem 'slim-rails'
gem 'bootstrap'
gem 'flatpickr_rails'
gem 'simple_form'

# API
# NOTE: active_model_serializers is widely used, but fast_jsonapi seems faster.
#   You might want to think of using Oj as a JSON parser with active_model_serializer if you need to handle huge traffic.
#   Because the default rails JSON parser is notorious for being slow.
gem 'active_model_serializers'

# MISC.
gem 'settingslogic'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
  gem 'pry-alias'
  gem 'pry-rescue'
  gem 'guard'
  gem 'faker'
  gem 'bundler-audit', require: false
  gem 'brakeman', require: false
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'bullet'
  gem 'guard-rspec', require: false
  gem 'rubocop', require: false
  gem 'guard-rubocop'
  gem 'overcommit'
  gem 'letter_opener'
  gem 'letter_opener_web'
  gem 'rails-erd'
  gem 'foreman'
  gem 'scss_lint', require: false
  gem 'slim_lint', require: false
  gem 'annotate'
end

group :test do
  gem 'capybara'
  gem 'capybara-email'
  gem 'email_spec'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'vcr'
  gem 'webmock'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'rspec_junit_formatter'
end

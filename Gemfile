# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'

gem 'rails', '~> 5.1.3'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'dotenv-rails'

# Front End
gem 'jquery-rails'
gem 'jquery-turbolinks'

# View
gem 'slim-rails'
gem 'bootstrap'
gem 'tether-rails'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
  gem 'pry-alias'
  gem 'pry-rescue'
  gem 'guard'
  gem 'awesome_print'
  gem 'faker'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'bullet'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'letter_opener_web'
  gem 'rails-erd'
end

group :test do
  gem 'capybara', '~> 2.13'
  gem 'capybara-email'
  gem 'email_spec'
  gem 'poltergeist', require: false
  gem 'selenium-webdriver', require: false
  gem 'database_cleaner'
  gem 'vcr'
  gem 'webmock'
  gem 'simplecov', require: false
  gem 'rubocop'
  gem 'timecop'
end

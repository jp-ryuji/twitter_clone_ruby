namespace :dev do
  require 'factory_bot_rails'
  require 'faker'

  desc 'Generate test data'
  task :generate_data, [:users_num, :post_min_num, :post_max_num] => :environment do |_, args|
    set_args(args)

    @args[:users_num].times do
      screen_name = loop do
        screen_name = Faker::Twitter.screen_name[0..14] # The method can return a word with more than 15 chars.
        break screen_name unless User.exists?(screen_name: screen_name)
      end

      FactoryBot.create(:user, screen_name: screen_name, posts_count: rand(@args[:post_min_num]..@args[:post_max_num]))
    end

    create_test_user

    all_user_ids = User.pluck(:id)
    User.all.each do |user|
      user.follower_ids = all_user_ids.reject { |id| id == user.id }
    end
  end
end

def create_test_user
  User.find_or_create_by(email: 'test@example.com') do |user|
    user.screen_name = 'test'
    user.password = 'password'
  end
end

def set_args(args)
  @args = {}
  @args[:users_num] = (args.users_num || 10).to_i
  @args[:post_min_num] = (args.post_min_num || 5).to_i
  @args[:post_max_num] = (args.post_max_num || 10).to_i
end

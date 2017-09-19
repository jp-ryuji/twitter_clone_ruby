namespace :dev do
  require 'factory_girl_rails'

  desc 'Generate test data'
  task :generate_data, [:users_num, :post_max_num] => :environment do |_, args|
    set_args(args)

    @args[:users_num].times do
      FactoryGirl.create(:user, posts_count: rand(5..@args[:post_max_num]))
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
  @args[:post_max_num] = (args.post_max_num || 10).to_i
end

namespace :dev do
  require 'factory_girl_rails'

  desc 'Generate test data'
  task :generate_data, [:users_num, :post_max_num] => :environment do |_, args|
    set_args(args)

    @args[:users_num].times do
      FactoryGirl.create(:user, posts_count: rand(5..@args[:post_max_num]))
    end
  end
end

def set_args(args)
  @args = {}
  @args[:users_num] = (args.users_num || 10).to_i
  @args[:post_max_num] = (args.post_max_num || 10).to_i
end

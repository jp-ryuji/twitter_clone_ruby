class HomeController < ApplicationController
  def index
    @post = Post.new
    # TODO Pagination
    @posts = Post.posts_by_following_users(current_user)
  end
end

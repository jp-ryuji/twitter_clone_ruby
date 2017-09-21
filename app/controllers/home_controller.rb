class HomeController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.posts_by_following_users(current_user).page(params[:page])
  end
end

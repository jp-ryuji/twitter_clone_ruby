class HomeController < ApplicationController
  before_action :require_login

  def index
    @post = Post.new
  end
end

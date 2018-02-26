# frozen_string_literal: true

module Admin
  class PostsController < Admin::BaseController
    before_action :set_post, only: %i[show edit update destroy]

    def index
      @posts = Post.includes(:user).order(created_at: :desc).page(params[:page])
    end

    def show; end

    def new
      @post = Post.new
    end

    def edit; end

    def create
      @post = Post.new(post_params)

      if @post.save
        redirect_to admin_posts_url, notice: "Post (by #{@post.user.screen_name}) was successfully created."
      else
        render :new
      end
    end

    def update
      if @post.update(post_params)
        redirect_to admin_posts_url, notice: "Post (by #{@post.user.screen_name}) was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @post.destroy
      redirect_to admin_posts_url, notice: "Post (by #{@post.user.screen_name}) was successfully destroyed."
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:user_id, :content)
    end
  end
end

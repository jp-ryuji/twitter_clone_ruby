# frozen_string_literal: true

require_relative '../application/post_application_service'

class PostsController < ApplicationController
  def create
    post_app_service = PostApplicationService.new

    begin
      @post = post_app_service.create_post(
        user_id: current_user.id,
        content: params[:post][:content]
      )
      redirect_to root_url, notice: 'Posted successfully'
    rescue ArgumentError => e
      redirect_to root_url, alert: e.message
    end
  end

  def advanced_search
    @form = AdvancedSearchForm.new(permitted_params)
    @posts = @form.search.page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def permitted_params
    params.permit(posts_search_form: AdvancedSearchForm::FORM_FIELDS)
  end
end

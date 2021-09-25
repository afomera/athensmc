class ForumCategoriesController < ApplicationController
  before_action :authenticate_user!, except: %w[index]
  before_action :set_category

  def index
    @forum_threads = ForumThread.filter_by_category(@category.id).filter_search(params[:q]).paginate(page: params[:page], per_page: params[:per_page])

    authorize @forum_threads
    render "forum_threads/index"
  end

  private

  def set_category
    @category = ForumCategory.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to forum_threads_path
  end
end

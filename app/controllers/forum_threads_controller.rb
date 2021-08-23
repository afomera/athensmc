class ForumThreadsController < ApplicationController
  before_action :authenticate_user!, except: %w[index show]
  before_action :set_forum_thread, except: %w[index new create]
  layout("new")

  def index
    @forum_threads =
      ForumThread.unscoped.order(sticky: :desc).filter_search(params[:q]).order(
        updated_at: :desc
      )
        .paginate(page: params[:page], per_page: params[:per_page])
    authorize @forum_threads
  end

  def edit
  end

  def update
    if @forum_thread.update(forum_thread_params)
      flash[:success] = "The forum thread has been updated."
      redirect_to @forum_thread
    else
      flash[:alert] = "An unknown error occurred, please try again."
      render "edit"
    end
  end

  def new
    @forum_thread = ForumThread.new
    @forum_thread.forum_posts.new
    authorize @forum_thread
  end

  def create
    @forum_thread = current_user.forum_threads.build(forum_thread_params)
    @forum_thread.forum_posts.each { |post| post.user_id = current_user.id }
    authorize @forum_thread

    if @forum_thread.save
      @forum_thread.touch(:last_post_created_at)
      flash[:success] = "Your thread has been posted."
      redirect_to @forum_thread
    else
      flash[:alert] = "Please try again"
      render action: :new
    end
  end

  def show
    @forum_post = ForumPost.new
  end

  def destroy
    @forum_thread.forum_posts.destroy_all
    @forum_thread.destroy
    flash[:success] = "The forum thread has been deleted."
    redirect_to forum_threads_path
  end

  def sticky
    @forum_thread.update_attributes(sticky: true)
    flash[:success] = "#{@forum_thread.subject} has been stickied!"
    redirect_to @forum_thread
  end

  def unsticky
    @forum_thread.update_attributes(sticky: false)
    flash[:success] = "#{@forum_thread.subject} has been un-stickied!"
    redirect_to @forum_thread
  end

  private

  def forum_thread_params
    params.require(:forum_thread).permit(
      :forum_category_id,
      :subject,
      forum_posts_attributes: %i[body]
    )
  end

  def set_forum_thread
    @forum_thread = ForumThread.friendly.find(params[:id])
    authorize @forum_thread
  end

  def search_query
    params[:q].presence || "*"
  end

  def search_params
    {
      order: {sticky: :desc, last_post_created_at: :desc},
      page: params[:page],
      per_page: 10
    }
  end
end

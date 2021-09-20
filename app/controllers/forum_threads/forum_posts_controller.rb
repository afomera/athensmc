class ForumThreads::ForumPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_forum_thread
  before_action :set_forum_post, only: %w[edit update destroy]

  def create
    @forum_post =
      @forum_thread.forum_posts.new(forum_post_params.merge(user: current_user))

    authorize @forum_post
    if @forum_post.save
      # Create Notifications for Posts
      (@forum_thread.users.uniq - [current_user]).each do |user|
        Notification.create(
          recipient: user,
          actor: current_user,
          action: "posted",
          notifiable: @forum_post
        )
      end

      @forum_thread.touch(:last_post_created_at)
      flash[:success] = "Successfully created your post"
      redirect_to forum_thread_path(
        @forum_thread,
        anchor: "forum_post_#{@forum_post.id}"
      )
    else
      flash[:alert] = "Unable to save your post"
      redirect_to @forum_thread
    end
  end

  def edit
    authorize @forum_post
  end

  def update
    authorize @forum_post
    if @forum_post.update(forum_post_params)
      flash[:success] = "Your post has been updated!"
      redirect_to @forum_thread
    else
      flash[:alert] = "An error occurred"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @forum_post
    @forum_post.destroy
    redirect_to @forum_post.forum_thread
  end

  private

  def set_forum_thread
    @forum_thread = ForumThread.friendly.find(params[:forum_thread_id])
  end

  def set_forum_post
    @forum_post = ForumPost.find(params[:id])
  end

  def forum_post_params
    params.require(:forum_post).permit(:body)
  end
end

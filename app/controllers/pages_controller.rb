class PagesController < ApplicationController
  before_action :authenticate_user!, only: %i[stats]

  def home
  end

  def stats
    @users_count = User.all.count
    @revisions_count = Revision.all.count
    @casts_count = Cast.all.count
    @whitelist_requests = WhitelistRequest.all
    @forum_threads_count = ForumThread.all.count
    @forum_category_count = ForumCategory.all.count
    @forum_posts_count = ForumPost.all.count
  end
end

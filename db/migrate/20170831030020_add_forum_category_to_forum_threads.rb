class AddForumCategoryToForumThreads < ActiveRecord::Migration[5.1]
  def change
    add_reference :forum_threads, :forum_category, foreign_key: true

    ForumThread.reset_column_information
    general = ForumCategory.find_by(name: "General")
    ForumThread.update_all(forum_category_id: general.id)
  end
end

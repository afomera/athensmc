# ForumPost
class ForumPost < ApplicationRecord
  belongs_to :forum_thread, counter_cache: true, touch: true
  belongs_to :user

  validates :body, presence: true
end

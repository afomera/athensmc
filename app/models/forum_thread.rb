# ForumThread
class ForumThread < ApplicationRecord
  include PgSearch::Model
  include Paginatable
  extend FriendlyId

  friendly_id :subject, use: :slugged

  belongs_to :forum_category, required: true
  belongs_to :user, required: true

  has_many :forum_posts, dependent: :destroy
  # forum_thread.users
  has_many :users, through: :forum_posts

  default_scope { order(created_at: :ASC) }

  accepts_nested_attributes_for :forum_posts

  validates :subject, presence: true
  validates_associated :forum_posts

  scope :filter_search,
    (
      lambda { |query|
        return all unless query.present?
        search(query)
      }
    )

  scope :filter_by_category,
    (
      lambda { |query|
        return all unless query.present?
        where(forum_category_id: query)
      }
    )

  pg_search_scope(
    :search,
    against: %i[subject slug sticky last_post_created_at forum_category_id],
    associated_against: {forum_posts: %i[body], forum_category: %i[id name]},
    using: {tsearch: {prefix: true, negation: true}}
  )
end

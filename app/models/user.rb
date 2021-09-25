# User
class User < ApplicationRecord
  include PgSearch::Model
  include Paginatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable

  before_validation :set_uuid, if: :minecraft_uuid_changed?

  validates :username,
    uniqueness: {case_sensitive: false},
    presence: true,
    length: {in: 2..32}

  validates :username,
    format: {
      message:
        "can only contain letters, numbers, underscores or dashes.",
      with: /\A[A-Za-z0-9\-_]+\z/
    }

  validates :minecraft_uuid,
    presence: true, on: :update, if: :minecraft_uuid_changed?

  has_many :revisions, dependent: :destroy
  has_many :casts, dependent: :destroy

  has_many :forum_threads, dependent: :destroy
  has_many :forum_posts, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy
  has_one :whitelist_request, dependent: :destroy

  attr_accessor :dashed_uuid

  scope :filter_search,
    (
      lambda { |query|
        return all unless query.present?
        search(query)
      }
    )

  pg_search_scope(
    :search,
    against: %i[username email minecraft_uuid],
    using: {tsearch: {prefix: true, negation: true}}
  )

  def member?
    # Check to make sure they have a whitelist request && that is approved.
    whitelist_request && whitelist_request.status == "approved"
  end

  def dashed_uuid
    if minecraft_uuid.present?
      uuid = minecraft_uuid.to_s
      "#{uuid[0..7]}-#{uuid[8..11]}-#{uuid[12..15]}-#{uuid[16..19]}-#{
        uuid[20..31]
      }"
    else
      "No UUID associated"
    end
  end

  private

  def set_uuid
    Minecraft::AccountLinker.new(self).execute
  end
end

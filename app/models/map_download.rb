# MapDownload
class MapDownload < ApplicationRecord
  include Paginatable

  validates :name, presence: true
  validates :description, presence: true
  validates :link, presence: true

  scope :descending, -> { order("created_at DESC") }
end

# Notification
class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  # Send the real-time notifications to anyone who's listening.
  after_commit -> { NotificationRelayJob.perform_later(self) }

  scope :unread, -> { where(read_at: nil).order("created_at DESC") }
  scope :for_user, ->(user) { where(recipient: user) }
  scope :recent, -> { limit(5).order("created_at DESC") }
end

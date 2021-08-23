class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    html =
      ApplicationController.render(
        partial: template(notification),
        locals: {notification: notification},
        formats: %i[html]
      )
    ActionCable.server.broadcast(
      "notifications:#{notification.recipient_id}",
      html: html
    )
  end

  private

  def template(notification)
    "notifications/#{notification.notifiable_type.underscore.pluralize}/#{
      notification.action
    }"
  end
end

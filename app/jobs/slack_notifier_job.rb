require "slack-notifier"

# SlackNotifierJob
class SlackNotifierJob < ApplicationJob
  queue_as :default
  attr_accessor :whitelist_request, :notifier

  def perform(whitelist_request)
    @whitelist_request = whitelist_request
    # Do something later
    Slack::Notifier::LinkFormatter.format(message)
    notifier.ping(
      message,
      icon_emoji: ":sparkles:", attachments: [more_user_info]
    )
  end

  private

  def notifier
    @notifier ||=
      Slack::Notifier.new(
        Rails.application.secrets.slack_token,
        username: "AthensMC Whitelist System"
      )
  end

  def message
    "<!here> New Whitelist Request!\n" \
      "#{whitelist_request.user.username} just applied for the community" \
      "\n#{whitelist_requests_link}"
  end

  def more_user_info
    {fallback: fallback_message, text: text, color: "good"}
  end

  def text
    "AthensMC Username: #{whitelist_request.user.username}\n" \
      "Minecraft UUID: #{whitelist_request.user.minecraft_uuid}\n" \
      "Referred by: #{whitelist_request.referred_by}"
  end

  def fallback_message
    "View whitelist requests on the site"
  end

  def whitelist_requests_link
    "[View Whitelist Requests](https://athensmc.com/admin/whitelist-requests)"
  end
end

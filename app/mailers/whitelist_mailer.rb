class WhitelistMailer < ApplicationMailer
  def request_received(user)
    @user = user
    mail(to: "andrea@zerlex.net", subject: "[AthensMC] New Whitelist Request")
  end

  def request_approved(whitelist_request)
    @user = whitelist_request.user
    @whitelist_request = whitelist_request
    mail(
      to: @user.email,
      subject: "[AthensMC] Your whitelist request has been approved!"
    )
  end

  def request_denied(whitelist_request)
    @user = whitelist_request.user
    @whitelist_request = whitelist_request
    mail(
      to: @user.email,
      subject: "[AthensMC] Your whitelist request has been denied."
    )
  end

  def request_removed(whitelist_request)
    @user = whitelist_request.user
    @whitelist_request = whitelist_request
    mail(
      to: @user.email,
      subject: "[AthensMC] Your whitelist request has been deleted."
    )
  end
end

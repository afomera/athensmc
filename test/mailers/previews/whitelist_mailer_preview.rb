# Preview all emails at http://localhost:3000/rails/mailers/whitelist_mailer
class WhitelistMailerPreview < ActionMailer::Preview
  def request_received
    @user = User.order("RANDOM() >= 0.1").first
    WhitelistMailer.request_received(@user)
  end
end

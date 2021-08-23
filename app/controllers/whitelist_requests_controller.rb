class WhitelistRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_minecraft_uuid?

  def index
    @whitelist_request = WhitelistRequest.new
  end

  def new
  end

  def create
    @whitelist_request =
      current_user.build_whitelist_request(whitelist_request_params)

    @whitelist_request.status = "pending"
    if @whitelist_request.save
      flash[:success] =
        "You've submitted your request to join." \
          " You should receive an email in 24-48 hours with a response."
      redirect_to root_path
    else
      flash[:alert] =
        "An error occurred while submitting your request. Please refresh to try again."
      render "index"
    end
  end

  private

  def whitelist_request_params
    params.require(:whitelist_request).permit(:agree_rules, :referred_by)
  end
end

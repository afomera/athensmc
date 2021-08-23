class Admin::WhitelistRequestsController < Admin::BaseController
  before_action :set_whitelist_id, only: %w[approve deny destroy]

  def index
    @whitelist_requests = WhitelistRequest.order("created_at DESC")
  end

  def pending
    @whitelist_requests = WhitelistRequest.status("pending")
    render action: :index
  end

  def approved
    @whitelist_requests = WhitelistRequest.status("approved")
    render action: :index
  end

  def denied
    @whitelist_requests = WhitelistRequest.status("denied")
    render action: :index
  end

  def show
    @whitelist_request = WhitelistRequest.find(params[:id])
  end

  # For Approving Whitelist Requests via patch
  def approve
    @whitelist_request.update_attributes(
      approved_on: Time.now, status: "approved", actor: current_user
    )
    flash[:success] =
      "#{@whitelist_request.user.username}'s application has been approved!"
    redirect_to admin_whitelist_requests_path
    WhitelistMailer.request_approved(@whitelist_request).deliver_later
  end

  # For denying whitelist requests via a patch method
  def deny
    @whitelist_request.update_attributes(
      denied_on: Time.now, status: "denied", actor: current_user
    )
    flash[:success] =
      "#{@whitelist_request.user.username}'s application has been denied!"
    redirect_to admin_whitelist_requests_path
    WhitelistMailer.request_denied(@whitelist_request).deliver_later
  end

  def destroy
    WhitelistMailer.request_removed(@whitelist_request).deliver_later
    @whitelist_request.destroy
    flash[:success] = "Whitelist Request Destroyed"
    redirect_to admin_whitelist_requests_path
  end

  private

  def set_whitelist_id
    @whitelist_request = WhitelistRequest.find_by_id(params[:format])
  end
end

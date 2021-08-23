# Admin::UsersController
class Admin::UsersController < Admin::BaseController
  skip_before_action :authenticate_user!, only: %w[whitelisted]
  skip_before_action :check_admin_status?, only: %w[whitelisted]

  def index
    @users =
      User.filter_search(params[:q]).paginate(
        page: params[:page], per_page: params[:per_page]
      )
        .decorate
    authorize [:admin, Draper.undecorate(@users)]
  end

  def show
    @user = User.find(params[:id])
    authorize [:admin, @user]
  end

  def whitelisted
    @users =
      User.joins(:whitelist_request).where(
        "whitelist_requests.status IN (?)",
        "approved"
      )
        .references(:whitelist_request)
    respond_to do |format|
      format.html do
        flash[:danger] = "Sorry only a JSON file is supported here"
        redirect_to admin_whitelist_requests_path
      end
      format.json
    end

    authorize [:admin, @users]
  end

  def email_list
    @users = User.all.order("id ASC")
    authorize [:admin, @users]
  end
end

class LinksController < ApplicationController
  before_action :authenticate_user!

  def minecraft
    @user = current_user
  end

  def create
    if current_user.update(user_params)
      # Did the user enter in the UUID? IF so save it.
      unless current_user[:minecraft_uuid].nil?
        flash[:success] =
          "Successfully saved your Minecraft account! If you have not already done so, you may apply for the server now."
        redirect_to whitelist_requests_path
      end
      if current_user[:minecraft_uuid].nil?
        flash[:danger] = "You need to enter a Minecraft Username"
        redirect_to links_minecraft_path
      end
    else
      unless current_user.update(user_params)
        flash[:danger] =
          'An error occurred while looking up your Minecraft UUID, please try again!
				Make sure you double check your spelling.. In addition the Minecraft account cannot already be associated with an account.'
        redirect_to links_minecraft_path
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:minecraft_uuid)
  end
end

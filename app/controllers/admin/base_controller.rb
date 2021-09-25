module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin_status?
  end
end

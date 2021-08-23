module Users
  class RegistrationsController < Devise::RegistrationsController
    layout("new")
  end
end

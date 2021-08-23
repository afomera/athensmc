module Api
  module Internal
    class WhitelistsController < ActionController::API
      # Returns a jbuilder template
      # Formatted with the user's AthensMC username and minecraft UUID
      def show
        @users =
          User.joins(:whitelist_request).where(
            "whitelist_requests.status IN (?)",
            "approved"
          )
            .references(:whitelist_request)
      end
    end
  end
end

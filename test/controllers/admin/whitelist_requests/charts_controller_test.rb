require "test_helper"

module Admin
  module WhitelistRequests
    class ChartsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:admin)
        sign_in(@user)
      end

      test "should get index" do
        get admin_whitelist_requests_charts_path
        assert_response :success
      end

      test "should not get index when unauthenticated" do
        sign_out(@user)
        get admin_whitelist_requests_charts_path
        assert_response :redirect
      end
    end
  end
end

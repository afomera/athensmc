require "test_helper"

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    sign_in(@user)
  end

  test "should get index" do
    get admin_users_path
    assert_response :success
  end

  test "should not get index when unauthenticated" do
    sign_out(@user)
    get admin_users_path
    assert_response :redirect
  end
end

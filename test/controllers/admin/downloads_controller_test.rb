require "test_helper"

class Admin::DownloadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    sign_in(@user)
  end

  test "should get index" do
    get admin_downloads_path
    assert_response :success
  end

  test "should not get index when unauthenticated" do
    sign_out(@user)
    get admin_downloads_path
    assert_response :redirect
  end
end

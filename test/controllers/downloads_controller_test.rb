require "test_helper"

class DownloadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get downloads_path
    assert_response :success
  end
end

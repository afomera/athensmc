require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
  end

  test "should get information page" do
    get information_path
    assert_response :success
  end

  test "should get stats page" do
    sign_in users(:admin)
    get stats_path
    assert_response :success
  end

  test "should get subscription page" do
    get subscribe_path
    assert_response :success
  end
end

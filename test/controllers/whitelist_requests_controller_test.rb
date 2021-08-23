require "test_helper"

class WhitelistRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @whitelist_request = whitelist_requests(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    User.any_instance.stubs(:minecraft_uuid).returns(
      "991ef20946474fe1900648f31e9697e7"
    )
    get whitelist_requests_path
    assert_response :success
  end
end

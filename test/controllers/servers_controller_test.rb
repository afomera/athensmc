require "test_helper"

class ServersControllerTest < ActionDispatch::IntegrationTest
  test "should get rrr server page" do
    get servers_rrr_path
    assert_response :success
  end

  test "should get direwolf20 page" do
    get servers_direwolf20_path
    assert_response :success
  end

  test "should get snapshot server page" do
    get servers_snapshot_path
    assert_response :success
  end

  test "should get vanilla server page" do
    get servers_vanilla_path
    assert_response :success
  end
end

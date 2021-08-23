require "test_helper"

class RevisionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @revision = revisions(:one)
    @user = users(:one)
  end

  test "should get index" do
    get revisions_path
    assert_response :success
  end

  test "should get show" do
    get revision_path(@revision)
    assert_response :success
  end

  test "should get new" do
    sign_in users(:admin)
    get new_revision_path
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:admin)
    get edit_revision_path(@revision)
    assert_response :success
  end
end

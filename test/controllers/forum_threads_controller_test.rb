require "test_helper"

class ForumThreadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @forum_thread = forum_threads(:one)
    sign_in @user
  end

  test "should get index" do
    get forum_threads_path
    assert_response :success
  end

  test "should get show" do
    get forum_thread_path(@forum_thread)
    assert_response :success
  end
end

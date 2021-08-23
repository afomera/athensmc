require "test_helper"

class CastsControllerTest < ActionDispatch::IntegrationTest
  setup { @cast = casts(:one) }

  test "should get index" do
    get casts_url
    assert_response :success
  end

  test "should get show" do
    get cast_path(@cast)
    assert_response :success
  end

  test "should get new" do
    sign_in users(:admin)
    get new_cast_path(@cast)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:admin)
    get edit_cast_path(@cast)
    assert_response :success
  end
end

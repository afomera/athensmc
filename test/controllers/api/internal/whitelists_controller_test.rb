require("test_helper")

module Api
  module Internal
    class WhitelistsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one)
        @user.update_columns(minecraft_uuid: "991ef20946474fe1900648f31e9697e7")
      end

      test "get show" do
        get api_internal_whitelist_url(format: :json)
        response_body = JSON.parse(response.body)
        assert_equal 1, response_body.size
        assert_equal 2, response_body.first.keys.size
        assert response_body.first.keys.include?("name")
        assert response_body.first.keys.include?("uuid")
      end
    end
  end
end

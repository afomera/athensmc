require "application_system_test_case"

module Users
  class SigningInTest < ApplicationSystemTestCase
    setup do
      visit root_url
      assert page.has_content?("Want a great gaming community?")
    end

    test "signing in from the home page" do
      click_on "Sign In"
      fill_in "user_email", with: "king601@test.athensmc.com"
      fill_in "user_password", with: "password"
      click_on "Log in"

      assert_text "Signed in successfully."
      # The user has been redirected back to the root_url
      assert page.has_content?("Want a great gaming community?")
    end

    test "unsuccessfully signing in from the home page" do
      click_on "Sign In"
      fill_in "user_email", with: "king601@test.athensmc.com"
      fill_in "user_password", with: "inconnect password"
      click_on "Log in"

      assert_text "Invalid Email or password."
      assert_no_text "Signed in successfully."
      assert_not page.has_content?("Want a great gaming community?")
    end
  end
end

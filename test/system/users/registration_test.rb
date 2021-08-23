require "application_system_test_case"

class RegistrationTest < ApplicationSystemTestCase
  setup do
    visit new_user_registration_url
    complete_registration_form
  end

  test "a user who fills out the form correctly is registered" do
    click_on "Create Account"
    assert_text "Welcome! You have signed up successfully."

    # Assert the flash message shows for newly created users
    # assert_text 'Please Link Your Mojang Account'
  end

  test "a user who incorrectly fills out the form is not registered" do
    fill_in "user_password", with: ""
    click_on "Create Account"
    assert_text "can't be blank"
    assert_text "doesn't match Password"
  end

  private

  def complete_registration_form
    fill_in "user_username", with: "randomusername"
    fill_in "user_email", with: "random@test.athensmc.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
  end
end

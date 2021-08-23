require "application_system_test_case"

class RootPathTest < ApplicationSystemTestCase
  setup do
    visit root_url
    assert page.has_content?("Want a great gaming community?")
  end

  test "ensure sign in link visible from home page" do
    assert_text("Sign In")
    click_on "Sign In"
  end
end

require "test_helper"
require "vcr_helper"

module Minecraft
  class AccountLinkerTest < ActiveSupport::TestCase
    include VcrHelper

    setup { @user = users(:one) }

    test "minecraft uuid changes to a mojang uuid after lookup" do
      VCR.use_cassette("services/minecraft/account_linker/correct_uuid") do
        @user.minecraft_uuid = "king601"
        @user.save
        assert_equal "991ef20946474fe1900648f31e9697e7", @user.minecraft_uuid
      end
    end
  end
end

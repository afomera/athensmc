# Minecraft::AccountLinker
#
# Enables us to link a Minecraft UUID with a user
module Minecraft
  class AccountLinker
    attr_accessor :user

    def initialize(user)
      @user = user
    end

    def execute
      user.update_column(:minecraft_uuid, mojang_uuid)
    end

    private

    # Returns a UUID from Mojang when the uuid is looked up.
    # Example:
    #   MojangApi.get_profile_from_name('king601').uuid
    #   => "991ef20946474fe1900648f31e9697e7"
    def mojang_uuid
      MojangApi.get_profile_from_name(user.minecraft_uuid).uuid
    end
  end
end

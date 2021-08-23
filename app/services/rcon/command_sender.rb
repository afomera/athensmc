require "rcon/rcon"

module Rcon
  class CommandSender
    attr_accessor :server, :command
    def initialize(server, command)
      @server = Server.find(server)
      @command = command
    end

    def send!
      rcon = ::RCON::Minecraft.new(@server.ip, @server.rcon_port)
      rcon.auth(@server.rcon_password)
      Rails.logger.info(rcon)
      command_output = rcon.command(@command)

      if command_output
        ActionCable.server.broadcast(
          "servers_channel",
          server_id: @server.id,
          command_recieved: @command.to_s,
          html: "<div>#{command_output}</div>"
        )
      end
      rcon.disconnect
    end
  end
end

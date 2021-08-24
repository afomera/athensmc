module Ssh
  # Ssh::TailLogs
  #
  # This class allows us to tail the logs of the minecraft instances via SSH
  class TailLogs < Ssh::Base
    LINES = 300

    def perform
      on server, server.ssh_username do |ssh|
        logs = ssh.exec!("tail -n#{LINES} #{@server.directory}/logs/latest.log")
        stripped_logs = logs.tr("<", "[").tr(">", "]").gsub("\n", "<br/>")
        ActionCable.server.broadcast(
          "servers_channel",
          server_id: server.id,
          command_recieved: "logs",
          html: "<div>#{stripped_logs}</div>"
        )
      end
    end
  end
end

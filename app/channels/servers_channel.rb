class ServersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "servers_channel"
  end

  def unsubscribed
    stop_all_streams
  end

  def send_command(params)
    Rcon::CommandSender.new(params["server_id"], params["command"]).send!
  end

  def fetch_logs(params)
    Ssh::TailLogs.new(Server.find(params["server_id"])).perform
  end
end

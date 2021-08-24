module Rcon
  class Minecraft < Query
    # Packet::Source object that was sent as a result of the last query
    attr_reader :packet
    # TCPSocket object
    attr_reader :socket
    # Host of connection
    attr_reader :host
    # Port of connection
    attr_reader :port
    # Authentication Status
    attr_reader :authed
    # return full packet, or just data?
    attr_accessor :return_packets

    #
    # Given a host and a port (dotted-quad or hostname OK), creates
    # a Query::Minecraft object. Note that this will still
    # require an authentication packet (see the auth() method)
    # before commands can be sent.
    #

    def initialize(host = "localhost", port = 25_575)
      @host = host
      @port = port
      @socket = nil
      @packet = nil
      @authed = false
      @return_packets = false
    end

    #
    # See Query#cvar.
    #

    def cvar(cvar_name)
      return_packets = @return_packets
      @return_packets = false
      response = super
      @return_packets = return_packets
      response
    end

    #
    # Sends a RCon command to the server. May be used multiple times
    # after an authentication is successful.
    #

    def command(command)
      if !@authed
        raise NetworkException.new(
          "You must authenticate the connection successfully before sending commands."
        )
      end

      @packet = Packet::Source.new
      @packet.command(command)

      @socket.print @packet.to_s
      rpacket = build_response_packet

      if rpacket.command_type != Packet::Source::RESPONSE_NORM
        raise NetworkException.new(
          "error sending command: #{rpacket.command_type}"
        )
      end

      if @return_packets
        rpacket
      else
        rpacket.string1
      end
    end

    #
    # Requests authentication from the RCon server, given a
    # password. Is only expected to be used once.
    #

    def auth(password)
      establish_connection

      @packet = Packet::Source.new
      @packet.auth(password)

      @socket.print @packet.to_s
      rpacket = nil
      rpacket = build_response_packet

      if rpacket.command_type != Packet::Source::RESPONSE_AUTH
        raise NetworkException.new(
          "error authenticating: #{rpacket.command_type}"
        )
      end

      @authed = true
      if @return_packets
        rpacket
      else
        true
      end
    end

    alias_method :authenticate, :auth

    #
    # Disconnects from the Minecraft server.
    #

    def disconnect
      if @socket
        @socket.close
        @socket = nil
        @authed = false
      end
    end

    protected

    #
    # Builds a Packet::Source packet based on the response
    # given by the server.
    #
    def build_response_packet
      rpacket = Packet::Source.new
      total_size = 0
      request_id = 0
      type = 0
      response = ""
      message = ""
      message2 = ""

      tmp = @socket.recv(4)
      return nil if tmp.nil?
      size = tmp.unpack("V1")
      tmp = @socket.recv(size[0])
      request_id, type, message, message2 = tmp.unpack("V1V1a*a*")
      total_size = size[0]

      rpacket.packet_size = total_size
      rpacket.request_id = request_id
      rpacket.command_type = type

      # strip nulls (this is actually the end of string1 and string2)
      message.sub!(/\x00\x00$/, "")
      message2.sub!(/\x00\x00$/, "")
      rpacket.string1 = message
      rpacket.string2 = message2
      rpacket
    end

    # establishes a connection to the server.
    def establish_connection
      @socket = TCPSocket.new(@host, @port) if @socket.nil?
    end
  end

  class NetworkException < RuntimeError; end
end

module Rcon
  class Packet; end

  class Packet::Source
    # execution command
    COMMAND_EXEC = 2
    # auth command
    COMMAND_AUTH = 3
    # auth response
    RESPONSE_AUTH = 2
    # normal response
    RESPONSE_NORM = 0
    # packet trailer
    TRAILER = "\x00\x00"

    # size of the packet (10 bytes for header + string1 length)
    attr_accessor :packet_size
    # Request Identifier, used in managing multiple requests at once
    attr_accessor :request_id
    # Type of command, normally COMMAND_AUTH or COMMAND_EXEC. In response packets, RESPONSE_AUTH or RESPONSE_NORM
    attr_accessor :command_type
    # First string, the only used one in the protocol, contains
    # commands and responses. Null terminated.
    attr_accessor :string1
    # Second string, unused by the protocol. Null terminated.
    attr_accessor :string2

    #
    # Generate a command packet to be sent to an already
    # authenticated RCon connection. Takes the command as an
    # argument.
    #
    def command(string)
      @request_id = rand(1_000)
      @string1 = string
      @string2 = TRAILER
      @command_type = COMMAND_EXEC

      @packet_size = build_packet.length

      self
    end

    #
    # Generate an authentication packet to be sent to a newly
    # started RCon connection. Takes the RCon password as an
    # argument.
    #
    def auth(string)
      @request_id = rand(1_000)
      @string1 = string
      @string2 = TRAILER
      @command_type = COMMAND_AUTH

      @packet_size = build_packet.length

      self
    end

    #
    # Builds a packet ready to deliver, without the size prepended.
    # Used to calculate the packet size, use #to_s to get the packet
    # that srcds actually needs.
    #
    def build_packet
      [@request_id, @command_type, @string1, @string2].pack(
        "VVa#{@string1.length}a2"
      )
    end

    # Returns a string representation of the packet, useful for
    # sending and debugging. This include the packet size.
    def to_s
      packet = build_packet
      @packet_size = packet.length
      [@packet_size].pack("V") + packet
    end
  end
end

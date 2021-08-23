module SSH
  class Base
    attr_accessor(:server)

    def initialize(server)
      @server = server
    end

    def on(server, user = "minecraft", &block)
      options = {
        auth_methods: %w[publickey],
        forward_agent: true,
        key_data: [server.ssh_private_key],
        keys: [],
        keys_only: true,
        port: 22,
        timeout: 5,
        # Wait up to 5 seconds trying to connect
        verify_host_key: :never
      }

      begin
        Net::SSH.start(server.ip, user, options) do |ssh|
          ssh.exec! "echo 'hello world'"
        end
      rescue => e
        puts e
      end

      Net::SSH.start(server.ip, user, options) do |ssh|
        # ssh.exec_sc! "mkdir -p .hatch", self
        # Do the command here we called in the other class:
        block
          .call(ssh)
      end
    end
  end
end

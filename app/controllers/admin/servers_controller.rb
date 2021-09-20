module Admin
  class ServersController < Admin::BaseController
    def index
      @servers = ::Server.all.decorate
    end

    def new
      @server = Server.new
    end

    def create
      @server = Server.new(server_params)

      if @server.save
        flash[:success] = "Server has been added"
        redirect_to admin_servers_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @server = Server.find(params[:id])
    end

    def edit
      @server = Server.find(params[:id])
    end

    def update
      @server = Server.find(params[:id])

      if @server.update(server_params)
        flash[:success] = "Server has been updated"
        redirect_to admin_servers_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def server_params
      params.require(:server).permit(
        :name,
        :ip,
        :game_port,
        :rcon_port,
        :query_port,
        :rcon_password,
        :ssh_username,
        :directory
      )
    end
  end
end

class Admin::DownloadsController < Admin::BaseController
  before_action :set_map_download, only: [:edit, :update, :destroy]

  def index
    @map_downloads =
      MapDownload.descending.paginate(page: params[:page], per_page: 15)
  end

  def create
    @map_download = MapDownload.new(map_download_params)

    if @map_download.save
      flash[:success] = "Download has been added!"
      redirect_to admin_downloads_path
    else
      render "new", status: :unprocessable_entity
    end
  end

  def new
    @map_download = MapDownload.new
  end

  def update
    if @map_download.update(map_download_params)
      flash[:success] = "Download has been updated!"
      redirect_to admin_downloads_path
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def edit
  end

  def destroy
    @map_download.destroy
    flash[:success] = "Download has been removed from the site."
    redirect_to admin_downloads_path
  end

  private

  def set_map_download
    @map_download = MapDownload.find(params[:id])
  end

  def map_download_params
    params.require(:map_download).permit(:name, :description, :link)
  end
end

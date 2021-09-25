# frozen_string_literal: true

# DownloadsController
class DownloadsController < ApplicationController
  before_action :authenticate_user!

  def index
    @map_downloads = MapDownload.descending.paginate(page: params[:page], per_page: page_limit)
  end

  private

  def page_limit
    params[:limit] || 10
  end
end

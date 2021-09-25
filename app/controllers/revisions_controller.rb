class RevisionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_revision, only: %i[show edit update destroy]
  before_action :require_admin_account!, only: %i[new edit create destroy update]

  def index
    @revision = Revision.order("created_at DESC").paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def create
    @revision = current_user.revisions.build(revision_params)

    if @revision.save
      flash[:success] = "Revision has been posted to the site."
      redirect_to @revision
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @revision = current_user.revisions.build
  end

  def edit
  end

  def update
    if @revision.update(revision_params)
      flash[:success] = "Revision has been updated."
      redirect_to @revision
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @revision.destroy
    flash[:success] = "The revision has been removed."
    redirect_to revisions_path
  end

  private

  def set_revision
    @revision = Revision.find(params[:id])
  end

  def revision_params
    params.require(:revision).permit(:title, :text)
  end
end

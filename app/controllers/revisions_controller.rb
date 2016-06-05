class RevisionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_revision, only: [:show, :edit, :update, :destroy]
  before_action :check_admin_status, only: [:new, :edit, :create, :destroy, :update]

  def index
    @revision = Revision.order('created_at DESC').paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def create
    @revision = current_user.revisions.build(revision_params)

    if @revision.save
      redirect_to @revision, notice: 'Revision has been posted to the site.'
    else
      render 'new'
    end
  end

  def new
    @revision = current_user.revisions.build
  end

  def edit
  end

  def update
    if @revision.update(revision_params)
      redirect_to @revision, notice: 'Revision has been updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @revision.destroy
    redirect_to revisions_path, notice: 'Revision has been destroyed'
  end

  private

  def set_revision
    @revision = Revision.find(params[:id])
    end

  def revision_params
    params.require(:revision).permit(:title, :text)
  end

  def check_admin_status
    authenticate_user!

    if current_user.admin
      return
    else
      redirect_to revisions_path, notice: 'You do not have permission to do that'
    end
  end
end

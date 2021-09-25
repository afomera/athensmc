class CastsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_cast, only: %i[show edit update destroy]
  before_action :require_admin_account!, only: %i[new edit create destroy update]

  def index
    @cast =
      Cast.order("created_at DESC").paginate(page: params[:page], per_page: 5)
    @cast_latest = Cast.last
  end

  def show
  end

  def create
    # render plain: params[:cast].inspect
    @cast = current_user.casts.build(casts_params)

    if @cast.save
      redirect_to @cast
    else
      render :new
    end
  end

  def new
    @last_cast = Cast.last

    @cast = current_user.casts.build
  end

  def edit
  end

  def update
    if @cast.update(casts_params)
      redirect_to @cast
    else
      render :edit
    end
  end

  def destroy
    render text: "Sorry this functionality is not built in!"
  end

  def suggest
    render plain: "Hello Suggestions"
  end

  private

  def set_cast
    @cast = Cast.friendly.find(params[:id])
  end

  def suggestion_params
    params.require(:suggestion).permit(:suggestion_text)
  end

  def casts_params
    params.require(:cast).permit(
      :episode,
      :releasedate,
      :description,
      :embedcode,
      :shownotes
    )
  end
end

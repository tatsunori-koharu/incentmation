class PromotionsController < ApplicationController
  before_action :set_promotions, only: [:show, :edit, :update, :destroy]

  def index
    @promotions = Promotion.all.order("created_at DESC")
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.create(promotion_params)
    if @promotion.save
      redirect_to promotions_path
    else
      render new_promotion_path
    end
  end

  def show
  end

  def edit
  end

  def update
    if @promotion.update(promotion_params)
      redirect_to promotions_path
    else
      render :edit
    end
  end

  def destroy
    @promotion.destroy
    redirect_to promotions_path
  end

  private

  def promotion_params
    params.require(:promotion).permit(:name, :content, :move, images: []).merge(user_id: current_user.id)
  end

  def set_promotions
    @promotion = Promotion.find(params[:id])
  end

end

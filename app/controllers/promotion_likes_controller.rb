class PromotionLikesController < ApplicationController
  before_action :set_like

  def create
    promotion = Promotion.find(params[:promotion_id])
    promotion_like = PromotionLike.create(user_id: current_user.id, promotion_id: promotion.id)
  end

  def destroy
    promotion =Promotion.find(params[:params_id])
    promotiom_like = PromotionLike.find(user_id: current_user.id, promotion_id: promotion.id)
    promotion_like.destroy
  end

  private

  def set_like
    @promotion = Promotion.find(params[:id])
  end
  
end

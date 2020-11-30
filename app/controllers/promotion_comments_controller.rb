class PromotionCommentsController < ApplicationController

  def create
    promotion_comment = PromotionComment.create(promotion_comment_params)
    redirect_to "/promotions/#{promotion_comment.promotion.id}"
  end

  private

  def promotion_comment_params
    params.require(:promotion_comment).permit(:comment).merge(user_id: current_user.id, promotion_id: params[:promotion_id])
  end

end

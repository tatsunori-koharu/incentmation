class ConsultationCommentsController < ApplicationController

  def create
    consultation_comment = ConsultationComment.create(consultation_comment_params)
    redirect_to "/consultations/#{consultation_comment.consultation.id}"
  end

  private

  def consultation_comment_params
    params.require(:consultation_comment).permit(:comment).merge(user_id: current_user.id, consultation_id: params[:consultation_id])
  end

end

class ConsultationFixesController < ApplicationController
  before_action :set_fix

  def create
    cousultation = Consultation.find(params[:consultation_id])
    consultation_fix = ConsultationFix.create(user_id: current_user.id, consultation_id: cousultation.id)
  end

  def destroy
    cousultation = Consultation.find(params[:consultation_id])
    consultation_fix = ConsultationFix.find_by(user_id: current_user.id, consultation_id: cousultation.id)
    consultation_fix.destroy
  end

  private

  def set_fix
    @cousultation = Consultation.find(params[:consultation_id])
  end
end

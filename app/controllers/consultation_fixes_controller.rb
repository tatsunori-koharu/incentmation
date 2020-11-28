class ConsultationFixesController < ApplicationController
  before_action :set_fix

  def create
    consultation = Consultation.find(params[:consultation_id])
    consultation_fix = ConsultationFix.create(user_id: current_user.id, consultation_id: consultation.id)
  end

  def destroy
    consultation = Consultation.find(params[:consultation_id])
    consultation_fix = ConsultationFix.find_by(user_id: current_user.id, consultation_id: consultation.id)
    consultation_fix.destroy
  end

  private

  def set_fix
    @consultation = Consultation.find(params[:consultation_id])
  end
end

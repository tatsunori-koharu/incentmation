class ConsultationsController < ApplicationController

  def index
    @consultations = Consultation.all.order("created_at DESC")
  end

  def new
    @consultation = Consultation.new
  end

  def create 
    @consultation = Consultation.create(consultation_params)
    if @consultation.save
      redirect_to consultations_path
    else
      render new_consultation_path
    end
  end

  def show
  end

  def edit
  end

  private

  def consultation_params
    params.reqire(:consultation).parmit(:title, :cotent).marge(user_id: current_user.id)
  end
  
end

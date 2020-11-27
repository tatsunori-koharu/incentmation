class ConsultationsController < ApplicationController
  before_action :set_consultation, only: :[:show, :edit, :update, :destroy]

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
    @consultation_comment = ConsultationComment.new
    @consultation_comments = @consultation.consultation_comments.includes(:user)
  end

  def edit
  end

  def update
    if @consultation.update(consultation_params)
      redirect_to consultations_path
    else
      render :edit
    end
  end

  def destroy
    @consultation.destroy
    redirect_to consultations_path
  end

  private

  def consultation_params
    params.reqire(:consultation).parmit(:title, :cotent).marge(user_id: current_user.id)
  end

  def set_consultation
    @consultation = Consultation.find(params[:id])
  end

end

class ConsultationsController < ApplicationController
  before_action :set_consultations, only: [:show, :edit, :update, :destroy]

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
      redirect_to @consultation
    else
      render :edit
    end
  end

  def destroy
    @consultation.destroy
    redirect_to consultations_path
  end

  def purge
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
  end

  private

  def consultation_params
    params.require(:consultation).permit(:title, :content, :category_id, :move, images: []).merge(user_id: current_user.id)
  end

  def set_consultations
    @consultation = Consultation.find(params[:id])
  end

end

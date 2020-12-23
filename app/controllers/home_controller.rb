class HomeController < ApplicationController

  before_action :set_search, only [:top, :search]

  def top
    @articles = Article.all.limit(5).order("created_at DESC")
    @consultations = Consultation.all.limit(5).order("created_at DESC")
    @promotions = Promotion.all.limit(5).order("created_at DESC")
  end

  def search
    @article_results = @a.result.includes(:category)
  end

  private

  def set_search
    @a = Article.rensack(params[:q])
  end
end

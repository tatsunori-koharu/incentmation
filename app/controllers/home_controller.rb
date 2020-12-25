class HomeController < ApplicationController

  def top
    @articles = Article.all.limit(5).order("created_at DESC")
    @consultations = Consultation.all.limit(5).order("created_at DESC")
    @promotions = Promotion.all.limit(5).order("created_at DESC")
    @categorys = Category.all
  end

  def search
    @article_items = Article.search(params[:keyword])
    @consultation_items = Consultation.search(params[:keyword])
    @promotion_items = Promotion.search(params[:keyword])
  end

end

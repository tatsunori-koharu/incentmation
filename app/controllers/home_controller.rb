class HomeController < ApplicationController
  def top
    @articles = Article.all.limit(5).order("created_at DESC")
    @consultations = Consultation.all.limit(5).order("created_at DESC")
  end
end

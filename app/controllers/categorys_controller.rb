class CategorysController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @article_categorys = Category.find(params[:id]).articles
    @consultation_categorys = Category.find(params[:id]).consultations
    @promotion_categorys = Category.find(params[:id]).promotions
  end
end

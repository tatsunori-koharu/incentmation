class HomeController < ApplicationController

  # before_action :set_search, only: [:top, :search, :set_category_column]

  def top
    @articles = Article.all.limit(5).order("created_at DESC")
    @consultations = Consultation.all.limit(5).order("created_at DESC")
    @promotions = Promotion.all.limit(5).order("created_at DESC")
    @categorys = Category.all
    # @contents = (Article.all) + (Consultation.all) + (Promotion.all)
  end

  def search
    @article_items = Article.search(params[:keyword])
    @consultation_items = Consultation.search(params[:keyword])
    @promotion_items = Promotion.search(params[:keyword])
    # @article_results = @a.result.includes(:category)
  end

  # def self.search(search)
  #   if search != ""
  #     @contents.where('text LIKE(?)', "%#{search}%")
  #   else
  #     puts "検索結果はありません"
  #   end
  # end

  # def set_category_column
  #   @article_results = @a.result
  #   category_id = params[:q][:category_id_eq]
  #   @category = Category.find_by(id: category_id)
  # end

  private

  # def set_search
  #   @a = Article.ransack(params[:q])
  # end
  
  # def set_category_column
  #   @article_results = @a.result
  #   category_id = params[:q][:category_id_eq]
  #   @category = Category.find_by(id: category_id)
  # end
end

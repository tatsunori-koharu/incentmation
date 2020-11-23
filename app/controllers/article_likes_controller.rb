class ArticleLikesController < ApplicationController
  before_action :set_like

  def create
    user = current_user
    article = Article.find(params[:article_id])
    article_like = ArticleLike.create(user_id: user.id, article_id: article.id)
  end

  def destroy
    user = current_user
    article = Article.find(params[:article_id])
    article_like = ArticleLike.find_by(user_id: user.id, article_id: article.id)
    article_like.destroy
  end

  private
  
  def set_like
    @article = Article.find(params[:article_id])
  end
end

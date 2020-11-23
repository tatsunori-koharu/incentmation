class ArticleCommentsController < ApplicationController

  def create
    Article_comment.create(article_comment_params)
    redirect_to "/articles/#{article_comment.article.id}"
  end

  private

  def article_comment_params
    params.require(:article_comment).permit(:text).merge(user_id: current_user.id, article_id: params[:article_id])
  end

end

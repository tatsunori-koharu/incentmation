class ArticlesController < ApplicationController
  before_action :set_articles, only: [:show, :edit, :update, :destroy]
  def index
    @articles = Article.all.order("created_at DESC")
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.create(article_params)
    if @article.save
      redirect_to articles_path
    else
      render new_article_path
    end
  end

  def show
    @article_comment = ArticleComment.new
    @article_comments = @article.article_comments.includes(:user)
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def purge
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
  end


  private

  def article_params
    params.require(:article).permit(:title, :content, :category_id, :move, images: []).merge(user_id: current_user.id)
  end

  def set_articles
    @article = Article.find(params[:id])
  end

end

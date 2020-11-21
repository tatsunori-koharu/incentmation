class ArticlesController < ApplicationController
  before_action :set_articles, only: [:show, :edit]
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.valid?
      @article.save
      redirect_to articles_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  private

  def article_params
    params.require(:article).permit(:title, :content).merge(user_id: current_user.id)
  end

  def set_articles
    @article = Article.find(params[:id])
  end

end

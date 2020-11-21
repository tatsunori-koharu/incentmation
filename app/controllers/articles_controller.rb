class ArticlesController < ApplicationController
  before_action: set_articles(:show, :edit)
  def index
    @articles = Article.include(:user)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
  end

  def show
  end

  def edit
  end

  private

  def article_params
    params.require(:article).permit(:title, :content).marge(user_id: current_user.id)
  end

  def set_articles
    @article = Article.find(params[:id])
  end

end

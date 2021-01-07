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
    @article.images.detach #全てのimageの紐付け解除
    if @article.update(article_params), notice: "投稿を更新しました"
      redirect_to articles_path
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def upload_image
    @image_blob = create_blob(params[:image])
    respond_to do |format|
      format.json { @image_blob.id }
    end
  end


  private

  def article_params
    params.require(:article).permit(:title, :content, :category_id, :move).merge(user_id: current_user.id, images: uploaded_images)
  end

  def set_articles
    @article = Article.find(params[:id])
  end

  def uploaded_images
    prams[:article][:images].map{|id| ActiveStorage::Blob.find(id)} if params[:article][:images]
  end

  def create_blob(uploading_file)
    ActiveStorage::Blob.create_after_upload! \
    io: uploading_file.open,
    filename: uploading_file.original_filename,
    content_type: uploading_file.content_type

end

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :xml, :json

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
    @count = 0
    for i in @articles
      @count = @count+1
    end
    respond_with @articles do |format|
      #format.json { render json: { "Articles" => @articles.as_json(:except => [:created_at,:updated_at], :root => false) }.to_json}
      format.json { render json: { "Articles" => @articles.as_json(:except => [:created_at,:updated_at], :root => false),
        "Total_elements" =>  @count.as_json,
        "Successs" => true}.to_json}
      format.xml  { render :xml => @articles.to_xml(:except => [:created_at,:updated_at])} 
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render action: 'show', status: :created, location: @article }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:name, :description, :price, :total_in_shelf, :total_in_vault, :store_id)
    end
end

class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js, :xml, :json
  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all
    respond_with @stores do |format|
      #format.json { render :text => @stores.to_json(:only => [ :id, :name ]) }
      format.json { render json: { "Stores" => @stores.as_json(:except => [:created_at,:updated_at],:root => false) }.to_json}
      format.xml  { render :xml => @stores.to_xml(:except => [:created_at,:updated_at])}  
    end
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @stores = Store.find(params[:id])
    @articles = @stores.articles

    respond_with @stores do |format|
      format.json { render json: { "Store" => [@stores.as_json(:only => [:name])] ,"Articles" => @articles.as_json(:except => [:created_at,:updated_at], :root => false)}.to_json}
      #format.json { render json: {"Store" => @stores.as_json(:only => [:name], :root => false)}.to_json}
      format.xml  { render :xml => @articles.to_xml(:except => [:created_at,:updated_at])} 
    end
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render action: 'show', status: :created, location: @store }
      else
        format.html { render action: 'new' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:name, :address)
    end
end

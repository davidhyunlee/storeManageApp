class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all.page(params[:page])
    authorize Store
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  	authorize Store
  end

  # GET /stores/new
  def new
    @store = Store.new
    authorize @store
  end

  # GET /stores/1/edit
  def edit
  	authorize Store
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)
    authorize Store

    respond_to do |format|
      if @store.save
        format.html { redirect_to stores_path, notice: 'Store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
  	authorize @store

    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to stores_path, notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    authorize Store
    
    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
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
      params.require(:store).permit(:name, :alias)
    end
end

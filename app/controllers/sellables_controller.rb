class SellablesController < ApplicationController
  before_action :set_sellable, only: [:show, :edit, :update, :destroy]

  # GET /sellables
  # GET /sellables.json
  def index
    @sellables = Sellable.all
  end

  # GET /sellables/1
  # GET /sellables/1.json
  def show
  end

  # GET /sellables/new
  def new
    @sellable = Sellable.new
  end

  # GET /sellables/1/edit
  def edit
  end

  # POST /sellables
  # POST /sellables.json
  def create
    @sellable = Sellable.new(sellable_params)

    respond_to do |format|
      if @sellable.save
        format.html { redirect_to @sellable, notice: 'Sellable was successfully created.' }
        format.json { render :show, status: :created, location: @sellable }
      else
        format.html { render :new }
        format.json { render json: @sellable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sellables/1
  # PATCH/PUT /sellables/1.json
  def update
    respond_to do |format|
      if @sellable.update(sellable_params)
        format.html { redirect_to @sellable, notice: 'Sellable was successfully updated.' }
        format.json { render :show, status: :ok, location: @sellable }
      else
        format.html { render :edit }
        format.json { render json: @sellable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sellables/1
  # DELETE /sellables/1.json
  def destroy
    @sellable.destroy
    respond_to do |format|
      format.html { redirect_to sellables_url, notice: 'Sellable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @sellable = Sellable.find_by(sku: params[:sku])
    @sku = params[:sku]
    respond_to do |format|
      format.js
    end      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sellable
      @sellable = Sellable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sellable_params
      params.require(:sellable).permit(:category_id, :carrier_id, :description, :sku, :msrp, :taxable_price, :retail_price, :estimated_on_hand, :taxable, :serialized)
    end
end

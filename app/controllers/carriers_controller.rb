class CarriersController < ApplicationController
  before_action :set_carrier, only: [:show, :edit, :update, :destroy]

  # GET /carriers
  # GET /carriers.json
  def index
    @carriers = Carrier.all.page(params[:page])
    authorize Carrier
  end

  # GET /carriers/1
  # GET /carriers/1.json
  def show
    authorize @carrier
  end

  # GET /carriers/new
  def new
    @carrier = Carrier.new
    authorize @carrier
  end

  # GET /carriers/1/edit
  def edit
    authorize @carrier
  end

  # POST /carriers
  # POST /carriers.json
  def create
    @carrier = Carrier.new(carrier_params)
    authorize @carrier

    respond_to do |format|
      if @carrier.save
        format.html { redirect_to carriers_path, notice: 'Carrier was successfully created.' }
        format.json { render :show, status: :created, location: @carrier }
      else
        format.html { render :new }
        format.json { render json: @carrier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carriers/1
  # PATCH/PUT /carriers/1.json
  def update
    authorize @carrier
    respond_to do |format|
      if @carrier.update(carrier_params)
        format.html { redirect_to carriers_path, notice: 'Carrier was successfully updated.' }
        format.json { render :show, status: :ok, location: @carrier }
      else
        format.html { render :edit }
        format.json { render json: @carrier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carriers/1
  # DELETE /carriers/1.json
  def destroy
    @carrier.destroy
    authorize @carrier

    respond_to do |format|
      format.html { redirect_to carriers_url, notice: 'Carrier was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carrier
      @carrier = Carrier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carrier_params
      params.require(:carrier).permit(:name)
    end
end

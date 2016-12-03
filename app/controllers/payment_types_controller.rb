class PaymentTypesController < ApplicationController
  before_action :set_payment_type, only: [:show, :edit, :update, :destroy]

  # GET /payment_types
  # GET /payment_types.json
  def index
    @payment_types = PaymentType.all
    authorize @payment_types
  end

  # GET /payment_types/1
  # GET /payment_types/1.json
  def show
    authorize @payment_type
  end

  # GET /payment_types/new
  def new
    @payment_type = PaymentType.new
    authorize @payment_type
  end

  # GET /payment_types/1/edit
  def edit
    authorize @payment_type
  end

  # POST /payment_types
  # POST /payment_types.json
  def create
    @payment_type = PaymentType.new(payment_type_params)
    authorize @payment_type

    respond_to do |format|
      if @payment_type.save
        format.html { redirect_to @payment_type, notice: 'Payment type was successfully created.' }
        format.json { render :show, status: :created, location: @payment_type }
      else
        format.html { render :new }
        format.json { render json: @payment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_types/1
  # PATCH/PUT /payment_types/1.json
  def update
    authorize @payment_type

    respond_to do |format|
      if @payment_type.update(payment_type_params)
        format.html { redirect_to @payment_type, notice: 'Payment type was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment_type }
      else
        format.html { render :edit }
        format.json { render json: @payment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_types/1
  # DELETE /payment_types/1.json
  def destroy
    authorize @payment_type
    begin
      @payment_type.destroy
    rescue ActiveRecord::InvalidForeignKey
      flash[:warning] = "There are payments that are utilizing this Payment Type. Unless you unassociate those payments with the payment type, you cannot delete this as it will leave payments with an unassociated payment type."
      redirect_to payment_types_path and return
    end

    respond_to do |format|
      format.html { redirect_to payment_types_url, notice: 'Payment type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_type
      @payment_type = PaymentType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_type_params
      params.require(:payment_type).permit(:name, :fee_amount, :fee, :carrier_id)
    end
end

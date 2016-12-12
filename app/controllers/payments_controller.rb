class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = current_store.payments.order("created_at DESC").page(params[:page])
    authorize @payments
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    authorize Payment
  end

  # GET /payments/new
  def new
    @payment = Payment.new
    @customer = Customer.find(params[:customer_id])
    authorize Payment
  end

  # GET /payments/1/edit
  def edit
    authorize @payment
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)
    @payment.store_id = current_store.id
    @payment.user_id = current_user.id
    authorize @payment

    if params[:payment][:payment_type_id] == ""
      redirect_to new_customer_payment_path(Customer.find(params[:payment][:customer_id])), notice: "Payment failed. No Payment Type selected." and return
    end

    # If Payment Type has a fee attached to it, add the fee to the payment amount.
    if @payment.payment_type.fee
      @payment.amount += @payment.payment_type.fee_amount
    end

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { redirect_to new_customer_payment_path(Customer.find(params[:payment][:customer_id]))
                      flash[:danger] = "Payment was not posted. There was an error. #{@payment.errors.inspect}" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    authorize @payment

    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    authorize @payment
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def carrier_and_payment_types
    authorize Payment
    @number = Number.find(params[:number_id])
    @customer = Customer.find(params[:customer_id])
    @payment_types = PaymentType.where(carrier_id: @number.carrier.id).or(PaymentType.where(carrier_id: nil))

    respond_to do |format|
      format.js
    end
  end

  def verify
    authorize Payment
    @payment = Payment.find(params[:id])
    @index = params[:index]

    if current_user.manager_accessible
      @payment.verify(current_user)
    elsif current_user.employee?
      @payment.employee_verify(current_user)
    end

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:amount, :invoice_id, :store_id, :customer_id, :carrier_id, :user_id, :number_id, :payment_type_id, :invoiced, :verifying_user)
    end
end

class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = current_store.invoices.order("created_at DESC").all
    authorize @invoices
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    authorize @invoice
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
    @customer = Customer.find(params[:customer_id])
    @sellables = Sellable.all

    authorize @invoice
  end

  # GET /invoices/1/edit
  def edit
    authorize @invoice
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @customer = Customer.find(params[:customer_id])
    @invoice = @customer.invoices.new(invoice_params)
    @invoice.store_id = current_store.id
    @invoice.user_id = current_user.id
    @invoice.customer_id = @customer.id
    authorize Invoice

    unless params[:invoice][:line_items_attributes]
      redirect_to new_customer_invoice_path(@customer), notice: "You tried to create a blank sale invoice." and return
    end

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { redirect_to new_customer_invoice_path(@customer), notice: @invoice.errors }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    authorize @invoice

    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    authorize @invoice

    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_serialized_line_item
    @serialized_line_item = SerializedItem.find_by(serial_number: params[:serial_number])
    @pricing = params[:pricing]
    @qty = params[:quantity]
    authorize Invoice

    respond_to do |format|
      format.js
    end
  end

  def add_simple_line_item
    sellable = Sellable.find_by(sku: params[:sku])
    @simple_item = SimpleItem.find_by(sellable_id: sellable.id)
    @quantity = params[:quantity]
    authorize Invoice

    respond_to do |format|
      format.js
    end
  end

  def add_payment_line_item
    @carrier = Carrier.find(params[:payment][:carrier_id])
    @payment_type = PaymentType.find(params[:payment][:payment_type_id])
    @number = Number.find(params[:payment][:number_id])
    @customer = @number.customer
    @amount = params[:amount]

    authorize Invoice

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:customer_id, :user_id, :store_id, :total, :sales_tax, :subtotal, :note, line_items_attributes: [ :invoice_id, :sellable_id, :simple_item_id, :serialized_item_id, :quantity, :tax_amount, :item_price, :sold_price ], payments_attributes: [:carrier_id, :number_id, :payment_type_id, :amount, :customer_id, :invoice_id, :user_id, :store_id])
    end
end

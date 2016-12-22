class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  has_scope :by_carrier
  has_scope :by_sku
  has_scope :by_description
  has_scope :by_on_hand
  has_scope :by_serial

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

    unless params[:invoice][:line_items_attributes] || params[:invoice][:payments_attributes]
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
    @carrier = Carrier.find(params[:carrier_id])
    @payment_type = PaymentType.find(params[:payment_type_id])
    @customer = Customer.find(params[:customer_id])
    @amount = params[:amount]
    @number = Number.find(params[:number_id])

    authorize Invoice

    respond_to do |format|
      format.js
    end
  end

  def add_plan
    @plan = Plan.find_by(code: params[:code])
    authorize Invoice

    respond_to do |format|
      format.js
    end
  end

  def add_plan_line_item
    @plan = Plan.find_by(code: params[:code])
    @sale_type = SaleType.find(params[:sale_type])

    authorize Invoice

    respond_to do |format|
      format.js
    end
  end

  def search_items
    @sellables = apply_scopes(Sellable).all.page(params[:page])

    authorize Invoice
    respond_to do |format|
      format.js
    end 
  end

  def add_item
    @sellable = Sellable.find_by(sku: params[:sku]) if params[:sku]
    @sellable = SerializedItem.find_by(serial_number: params[:serial_number]).sellable if params[:serial_number]
    @serialized_item = SerializedItem.find_by(serial_number: params[:serial_number])

    authorize Invoice

    respond_to do |format|
      format.js
    end
  end

  def search_serialized
    @serialized_items = apply_scopes(SerializedItem).where(store_id: current_store.id, quantity: 1).page(params[:page])

    authorize Invoice
    respond_to do |format|
      format.js
    end 
  end

  def search_simple
    @simple_items = apply_scopes(SimpleItem).where("store_id = ? AND quantity > 0", current_store.id).page(params[:page])

    authorize Invoice
    respond_to do |format|
      format.js
    end 
  end

  def add_number
    @number = Number.new
    @number.customer_id = params[:customer_id]
    @number.carrier_id = params[:carrier_id]
    @number.number = params[:number]
    @number.phone_model = params[:phone_model]
    @number.imei = params[:imei]
    @number.iccid = params[:iccid]
    @customer = Customer.find(params[:customer_id])

    authorize Invoice

    if @number.save
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render :file => "invoices/number_error.js.erb" }
      end
    end
  end

  def number_details
    @customer = Customer.find(params[:customer_id])
    @number = Number.find(params[:number_id])
    @payment_types = PaymentType.where(carrier_id: @number.carrier.id).or(PaymentType.where(carrier_id: nil))

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
      params.require(:invoice).permit(:customer_id, :user_id, :store_id, :total, :sales_tax, :subtotal, :note, line_items_attributes: [ :invoice_id, :sale_type_id, :sellable_id, :simple_item_id, :serialized_item_id, :quantity, :tax_amount, :item_price, :sold_price, :plan_id, :sale_type, :payment_id], payments_attributes: [:carrier_id, :number_id, :payment_type_id, :amount, :customer_id, :invoice_id, :user_id, :store_id, :invoiced])
    end
end

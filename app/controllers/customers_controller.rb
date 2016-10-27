class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    if params[:query]
      if params[:query].length == 10 && params[:query].to_i != 0
        @numbers = Number.where(number: params[:query])
        @page_title = "Search Results for: #{params[:query]}"
      elsif /^.+@.+$/.match(params[:query]).class == MatchData
        @customers = Customer.where(email: params[:query])
        @page_title = "Search Results for E-mail: #{params[:query]}"
      elsif params[:query] == ""
        @customers = Customer.all
        @page_title = "Listing All Customers"
      end
    else
      @customers = Customer.all
      @page_title = "Customer Listing"
    end

    authorize Customer
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @page_title = "Customer Profile: #{@customer.first_name} #{@customer.last_name}"
    authorize @customer
  end

  # GET /customers/new
  def new
    @page_title = "New Customer"
    @customer = Customer.new
    @customer.numbers.build
    authorize @customer
  end

  # GET /customers/1/edit
  def edit
    authorize @customer
    @page_title = "Edit Customer Profile"
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    authorize @customer

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    authorize @customer
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
        flash[:success] = "Customer was updated."
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_number
    authorize Customer
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:first_name, :middle_name, :last_name, :address, :address_2, :city, :state, :zip, :email, :last4, :pin, :notes, :dob, numbers_attributes: [ :id, :carrier_id, :number, :phone_model, :imei, :iccid, :act_date ])
    end
end

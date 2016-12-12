class TenantsController < ApplicationController
  before_action :set_tenant, only: [:show, :edit, :update, :destroy]

  # GET /tenants
  # GET /tenants.json
  def index
    @tenants = Tenant.all.page(params[:page])
    authorize @tenants
  end

  # GET /tenants/1
  # GET /tenants/1.json
  def show
    authorize @tenant
  end

  # GET /tenants/new
  def new
    @tenant = Tenant.new
    authorize @tenant
  end

  # GET /tenants/1/edit
  def edit
    authorize @tenant
  end

  # POST /tenants
  # POST /tenants.json
  def create
    @tenant = Tenant.new(tenant_params)
    authorize @tenant

    respond_to do |format|
      if @tenant.save
        format.html { redirect_to @tenant, notice: 'Tenant was successfully created.' }
        format.json { render :show, status: :created, location: @tenant }
      else
        format.html { render :new }
        format.json { render json: @tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tenants/1
  # PATCH/PUT /tenants/1.json
  def update
    authorize @tenant
    respond_to do |format|
      if @tenant.update(tenant_params)
        format.html { redirect_to @tenant, notice: 'Tenant was successfully updated.' }
        format.json { render :show, status: :ok, location: @tenant }
      else
        format.html { render :edit }
        format.json { render json: @tenant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tenants/1
  # DELETE /tenants/1.json
  def destroy
    authorize @tenant
    @tenant.destroy
    respond_to do |format|
      format.html { redirect_to tenants_url, notice: 'Tenant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tenant
      @tenant = Tenant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tenant_params
      params.require(:tenant).permit(:goal, :date_applied, :first_name, :last_name, :employment, :employment_contact, :paycheck_amount, :ssn, :phone_number, :email, :property_type, :bed, :bath, :laundry, :sqft, :rent_budget, :area, :move_in_date, :note, :family_count, :tenant_names, :pets, :current_lease, :current_address, :reference_name, :reference_contact, :introduced, :option_address1, :option_address2, :option_address3, :option_address4, :option_address5, :option_address6)
    end
end

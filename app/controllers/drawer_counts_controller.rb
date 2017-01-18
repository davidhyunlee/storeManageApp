class DrawerCountsController < ApplicationController
  before_action :set_drawer_count, only: [:show, :edit, :update, :destroy]

  # GET /drawer_counts
  # GET /drawer_counts.json
  def index
    @drawer_counts = DrawerCount.where(store_id: current_store.id)
    authorize @drawer_counts
  end

  # GET /drawer_counts/1
  # GET /drawer_counts/1.json
  def show
    authorize @drawer_count
  end

  # GET /drawer_counts/new
  def new
    @drawer_count = DrawerCount.where(store_id: current_store.id, created_at: Time.now.beginning_of_day.utc..Time.now.end_of_day.utc).first_or_initialize
    authorize @drawer_count
  end

  # GET /drawer_counts/1/edit
  def edit
  end

  # POST /drawer_counts
  # POST /drawer_counts.json
  def create
    @drawer_count = DrawerCount.new(drawer_count_params)
    card_digits = params[:card_digits]
    charged_amount = params[:charged_amount]
    @drawer_count.user_id = current_user.id
    @drawer_count.store_id = current_store.id
    
    authorize @drawer_count

    if params[:card_digits]
      card_digits.each_with_index do |digits, index|
        @drawer_count.card_receipts.build(number: digits, charged_amount: charged_amount[index])
      end
    end

    respond_to do |format|
      if @drawer_count.save
        format.html { redirect_to @drawer_count, notice: 'Drawer count was successfully created.' }
        format.json { render :show, status: :created, location: @drawer_count }
      else
        format.html { render :new }
        format.json { render json: @drawer_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drawer_counts/1
  # PATCH/PUT /drawer_counts/1.json
  def update
    authorize @drawer_count
    respond_to do |format|
      if @drawer_count.update(drawer_count_params)
        format.html { redirect_to @drawer_count, notice: 'Drawer count was successfully updated.' }
        format.json { render :show, status: :ok, location: @drawer_count }
      else
        format.html { render :edit }
        format.json { render json: @drawer_count.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drawer_counts/1
  # DELETE /drawer_counts/1.json
  def destroy
    authorize @drawer_count
    @drawer_count.destroy
    respond_to do |format|
      format.html { redirect_to drawer_counts_url, notice: 'Drawer count was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_additional_card_data
    authorize DrawerCount

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drawer_count
      @drawer_count = DrawerCount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drawer_count_params
      params.require(:drawer_count).permit(:ones, :twos, :fives, :tens, :twenties, :fifties, :hundreds, :total, :cash_total, :card_total, :note)
    end
end

class SerializedItemsController < ApplicationController
  def index
  end

  def edit
    @serialized_item = SerializedItem.find(params[:id])
    authorize SerializedItem
  end

  def update
    @serialized_item = SerializedItem.find(params[:id])
    authorize @serialized_item

    respond_to do |format|
      if @serialized_item.update(serialized_item_params)
        format.html { redirect_to serialized_inventory_path, notice: 'Serialized item was successfully updated.' }
        format.json { render :show, status: :ok, location: @serialized_item }
      else
        format.html { render :edit }
        format.json { render json: @serialized_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @serialized_item = SerializedItem.find(params[:id])
    @line_item = LineItem.find_by(serialized_item_id: params[:id])
    @invoice = @line_item.invoice
    
    authorize @serialized_item
  end

  def destroy
  	@serialized_item = SerializedItem.find(params[:id])
  	@serialized_item.destroy
    authorize @serialized_item

    respond_to do |format|
      format.html { redirect_to inventory_path, notice: 'Serialized Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sold
    if params[:query] == ""
      @serialized_items = SerializedItem.basic_search(serial_number: params[:query]).order(updated_at: :desc).page(params[:page])
    elsif params[:query]
      @serialized_items = SerializedItem.where(quantity: 0, store_id: current_store.id).order(updated_at: :desc).page(params[:page])
    else
      @serialized_items = SerializedItem.where(quantity: 0, store_id: current_store.id).order(updated_at: :desc).page(params[:page])
    end
      
    authorize @serialized_items
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def serialized_item_params
      params.require(:serialized_item).permit(:store_id, :serial_number, :sellable_id, :locked, :cost)
    end
end

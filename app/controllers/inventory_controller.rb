class InventoryController < ApplicationController

  def receive 
  end

  def search
    @sellable = Sellable.find_by(sku: params[:sku])
    @sku = params[:sku]
    respond_to do |format|
      format.js
    end 
  end

  def add_serialized_to_queue
    @serialized_line_item = SerializedItem.find_by(serial_number: params[:serial_number])
    @qty = params[:quantity]

    respond_to do |format|
      format.js
    end
  end

end

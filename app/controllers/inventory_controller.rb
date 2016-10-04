class InventoryController < ApplicationController

  def receive
    @store = current_store.id
  end

  def search
    @sellable = Sellable.find_by(sku: params[:sku])
    @sku = params[:sku]
    respond_to do |format|
      format.js
    end 
  end

  def add_serialized_to_queue
    @sellable = Sellable.find_by(id: params[:sellable_id])
    @qty = params[:quantity]
    @cost = params[:cost]
    @store = current_store.id

    respond_to do |format|
      format.js
    end
  end

  def save
    @serialized_items = params[:serialized_items]
    @simple_items = params[:simple_item]
    @current_store = current_store

    @serialized_items.each do |item|
      SerializedItem.create(store_id: @current_store.id, serial_number: item["serial_number"], sellable_id: item["sellable_id"], quantity: item["quantity"], user_id: item["user_id"], cost: item["cost"])
    end

  end

end

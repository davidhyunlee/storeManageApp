class InventoryController < ApplicationController
  def receive
    @store = current_store.id
    authorize :inventory, :receive?
  end

  def search
    authorize :inventory, :search?
    @sellable = Sellable.find_by(sku: params[:sku])
    @sku = params[:sku]
    respond_to do |format|
      format.js
    end 
  end

  def add_serialized_to_queue
    authorize :inventory, :add_serialized_to_queue?
    @sellable = Sellable.find_by(id: params[:sellable_id])
    @qty = params[:quantity]
    @cost = params[:cost]
    @store = current_store.id

    respond_to do |format|
      format.js
    end
  end

  def save
    authorize :inventory, :save?
    @serialized_items = params[:serialized_items]
    @simple_items = params[:simple_item]
    @current_store = current_store

    # Testing for duplicate serial number entry.
    if @serialized_items
      @serialized_items.each do |item|
        if SerializedItem.find_by(serial_number: item["serial_number"])
          flash.keep[:warning] = "Product with serial number of #{item["serial_number"]} has been found in the database. Inventory receive aborted."
          redirect_to action: "receive", flash: { success: "HEY" } and return
          # render :receive
        end
      end
    end

    # @serialized_items.each do |item|
    #   SerializedItem.create(store_id: @current_store.id, serial_number: item["serial_number"], sellable_id: item["sellable_id"], quantity: item["quantity"], user_id: item["user_id"], cost: item["cost"])
    # end

    # if @simple_items
    #   @simple_items.each do |item|
    #     SimpleItem.where(sellable_id: item["sellable_id"], store_id: item["store_id"]).first_or_initialize do |item|
    #       item.sellable_id = 
    #     end
    #   end
    # end

  end

end

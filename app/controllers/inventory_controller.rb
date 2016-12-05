class InventoryController < ApplicationController
  def index
    @simple_items = SimpleItem.where("store_id = ? AND quantity > 0", current_store.id)
    @serialized_items = SerializedItem.where(store_id: current_store.id, quantity: 1).order(:sellable_id).page(params[:page])

    authorize :inventory, :index?
  end

  def simple_inventory
    @inventory = SimpleItem.where("store_id = ? AND quantity > 0", current_store.id).order(:sellable_id).page(params[:page])

    authorize :inventory, :simple_inventory?
  end

  def serialized_inventory
    @inventory = SerializedItem.where(store_id: current_store.id, quantity: 1).order(:sellable_id).page(params[:page])

    authorize :inventory, :serialized_inventory?
  end

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

  def add_sellable_to_queue
    authorize :inventory, :add_sellable_to_queue?
    @sellable = Sellable.find_by(id: params[:sellable_id])
    @quantity = params[:quantity]
    @cost = params[:cost]
    @store = current_store.id

    respond_to do |format|
      format.js
    end
  end

  def inventory_list
    @simple_items = SimpleItem.where("store_id = ? AND quantity > 0", current_store.id)
    @serialized_items = SerializedItem.where(store_id: current_store.id, quantity: 1)
    authorize :inventory, :inventory_list?

    respond_to do |format|
      format.js
    end
  end

  def save
    authorize :inventory, :save? 
    @serialized_items = params[:serialized_items]
    @simple_items = params[:simple_items]
    @current_store = current_store
    @created_serialized_items = []

    # Case when users try to receive nothing.
    unless params[:serialized_items]
      flash[:success] = "Congratulations, you have received absolutely nothing! :)"
      render :receive and return
    end

    # Testing for duplicate serial number or blank serial number entry.
    if @serialized_items
      @serialized_items.each do |item|
        if SerializedItem.find_by(serial_number: item["serial_number"])
          if item["serial_number"] == "" 
            flash[:warning] = "You have entered a blank serial number. Inventory receipt aborted."
          else
            flash[:warning] = "Product with serial number of #{item["serial_number"]} has been found in the database. Inventory receipt aborted."
          end
          render :receive and return
        end
      end
    end

    if @serialized_items
      @serialized_items.each do |item|
        serialized_item = SerializedItem.new(store_id: @current_store.id, serial_number: item["serial_number"], sellable_id: item["sellable_id"], quantity: item["quantity"], user_id: item["user_id"], cost: item["cost"])
        if serialized_item.save
          @created_serialized_items << item["serial_number"]
        else
          flash[:warning] = "#{serialized_item.errors.full_messages}"
          render :receive and return
        end
      end
    end

    if @simple_items
      @simple_items.each do |item|

        if SimpleItem.where(sellable_id: item["sellable_id"], store_id: item["store_id"]).empty?
          item_to_create = SimpleItem.new
          item_to_create.sellable_id = item["sellable_id"]
          item_to_create.store_id = item["store_id"]
          item_to_create.quantity = item["quantity"]
          item_to_create.save
        else
          item_to_update = SimpleItem.find_by(sellable_id: item["sellable_id"], store_id: item["store_id"])
          item_to_update.quantity = 0 if item_to_update.quantity == nil
          item_to_update.quantity += item["quantity"].to_i
          item_to_update.save
        end

      end
    end

    redirect_to dashboard_path, flash: {success: "Inventory has been successfully received."}

  end

end

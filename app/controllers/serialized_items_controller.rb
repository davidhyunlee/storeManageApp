class SerializedItemsController < ApplicationController
  def index
  end

  def edit
  end

  def show
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
end

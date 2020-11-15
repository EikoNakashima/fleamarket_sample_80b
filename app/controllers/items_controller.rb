class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
  end

  def delete
  end

  def purchases
  end

  private

  def item_params
    params.require(:item).permit(:name, :text, :price, :shipment_sorce_id, :condition_id, :brand_id, :catebory_id, :cost_id, :days_to_ship_id, :seller_id, :buyer_id)
  end


end
class ItemsController < ApplicationController
  before_action :get_category
  # before_action :category_parent_array, only: [:new, :create, :edit]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  # before_action :show_all_instance, only: [:show, :edit, :destroy]

  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました'
    else
      flash.now[:alert] = '必須事項を入力してください'
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      # redirect_to item_path
    else
      render :edit
    end
  end

  def update_done
    @item_update = Item.order("updated_at DESC").first
  end

  def destroy
    if @item.destroy
      redirect_to root_path, notice: '商品を削除しました'
    else
      flash.now[:alert] = '商品を削除できませんでした'
      render :show
    end
  end

  def purchases
  end

  def category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private

  def get_category
    @category_parent = Category.where(ancestry: nil)
  end


  def item_params
    params.require(:item).permit(:name, :text, :price, :brand, :prefecture_id, :category_id, :condition_id, :cost_id, :days_id, images_attributes: [:photo, :_destory, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])                               
  end

  # def category_parent_array
  #   @category_parent_array = Category.where(ancestry: nil)      
  # end

  # def show_all_instance
  #   # @user = User.find(@item.user_id)
  #   @images = Image.where(item_id: params[:id])                  
  #   @images_first = Image.where(item_id: params[:id]).first
  #   @category_id = @item.category_id                             
  #   @category_parent = Category.find(@category_id).parent.parent                    
  #   @category_child = Category.find(@category_id).parent
  #   @category_grandchild = Category.find(@category_id)
  # end

end
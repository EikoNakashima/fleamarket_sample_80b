class ItemsController < ApplicationController
  before_action :get_category, only: [:new, :create]
  before_action :category_parent_array, only: [ :update, :edit]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :show_all_instance, only: [:show, :edit, :update, :destroy]
  before_action :category_map, only: [:edit, :update]

  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def show
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
    if item_params[:images_attributes].nil?
      flash.now[:alert] = '更新できませんでした 【画像を１枚以上入れてください】'
      render :edit
    else
      exit_ids = []
      item_params[:images_attributes].each do |a,b|
        exit_ids << item_params[:images_attributes].dig(:"#{a}",:id).to_i
      end
      ids = Image.where(item_id: params[:id]).map{|image| image.id }
      exit_ids_uniq = exit_ids.uniq
      delete__db = ids - exit_ids_uniq
      Image.where(id:delete__db).destroy_all
      @item.touch
      if @item.update(item_params)
        redirect_to  root_path
      else
        flash.now[:alert] = '更新できませんでした'
        render :edit
      end
    end

    # if @item.update(item_params)
    #   # redirect_to item_path
    # else
    #   render :edit
    # end
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

  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def get_category_grandchildren
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

  def category_parent_array
    @category_parent_array = Category.where(ancestry: nil)      
  end

  def show_all_instance
    # @user = User.find(@item.user_id)
    @images = Image.where(item_id: params[:id])                  
    @images_first = Image.where(item_id: params[:id]).first
    @category_id = @item.category_id                             
    @category_parent = Category.find(@category_id).parent.parent                    
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
  end

  def category_map
    grandchild = @item.category
    child = grandchild.parent
    if @category_id == 12 or @category_id == 23 or @category_id == 40 or @category_id == 52 or @category_id == 65 or @category_id == 79 or @category_id == 90 or @category_id == 101 or @category_id == 111 or @category_id == 120 or @category_id == 129 or @category_id == 138 or @category_id == 148
    else
      @parent_array = []
      @parent_array << @item.category.parent.parent.name
      @parent_array << @item.category.parent.parent.id
    end
    @category_children_array = Category.where(ancestry: child.ancestry)
    @child_array = []
    @child_array << child.name
    @child_array << child.id

    @category_grandchildren_array = Category.where(ancestry: grandchild.ancestry)
    @grandchild_array = []
    @grandchild_array << grandchild.name
    @grandchild_array << grandchild.id
  end
end
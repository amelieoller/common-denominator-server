class Api::V1::ItemsController < ApplicationController
  before_action :find_item, only: [:update, :destroy]

  def index
    slug = params[:category_id].parameterize
    # category = current_user.categories.where("lower(slug) = ?", slug).take
    category = Category.where("lower(slug) = ? and user_id = ?", slug, current_user.id).take

    if category && category.items
      render json: category.items
    else
      render json: { "errors": ["No items found"] }
    end
  end

  def create
    item = Item.create(item_params)

    render json: item
  end

  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: { "message": "Could not update item, please try again" }
    end
  end

  def destroy
    if @item.destroy
      render json: { "message": "Successfully removed item" }
    else
      render json: { "message": "Could not remove item, please try again" }
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :category_id)
  end

  def find_item
    @item = Item.find(params[:id])
  end
end

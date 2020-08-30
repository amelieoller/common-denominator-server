class Api::V1::CategoriesController < ApplicationController
  def index
    categories = Category.all

    render json: CategorySerializer.new(categories).serialized_json
  end

  def create
    category = Category.create(category_params)
    byebug
    render json: CategorySerializer.new(category).serialized_json
  end

  private

  def category_params()
    params.require(:category).permit(:title, :user_id)
  end
end

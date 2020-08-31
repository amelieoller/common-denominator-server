class Api::V1::CategoriesController < ApplicationController
  def index
    categories = Category.all

    render json: categories
  end

  def create
    category = Category.create(category_params)

    if category.valid?
      render json: category
    else
      render json: { "errors": category.errors.full_messages }
    end
  end

  def destroy
    category = Category.find(params[:id])

    if category.destroy
      render json: { "message": "Successfully removed category" }
    else
      render json: { "errors": ["Could not remove category, please try again"] }
    end
  end

  private

  def category_params
    params.require(:category).permit(:title, :user_id)
  end
end

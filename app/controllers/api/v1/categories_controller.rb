require "benchmark"

class Api::V1::CategoriesController < ApplicationController
  def index
    categories = current_user.categories

    if categories
      render json: categories
    else
      render json: { "errors": "There was a problem fetching categories" }
    end
  end

  def show
    category = Category.find(params[:id])

    if category
      render json: category
    else
      render json: { "errors": "There was a problem fetching categories" }
    end
  end

  def create
    category = current_user.categories.build(category_params)

    if category.save
      render json: category
    else
      render json: { "errors": category.errors.full_messages }
    end
  end

  def destroy
    category = current_user.categories.find(params[:id])

    if category.destroy
      render json: { "message": "Successfully removed category" }
    else
      render json: { "errors": ["Could not remove category, please try again"] }
    end
  end

  private

  def category_params
    params.require(:category).permit(:title, :custom_friendship_id)
  end
end

# puts "----------------------------------"
# puts Benchmark.measure {
#   puts "***********************"
#   category = current_user.categories.find(params[:id])
#   puts "***********************"
# }
# puts "----------------------------------"

# puts Benchmark.measure {
#   puts "***********************"
#   category = Category.find(params[:id])
#   puts "***********************"
# }
# puts "----------------------------------"

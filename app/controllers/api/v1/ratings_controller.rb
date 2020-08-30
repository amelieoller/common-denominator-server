class Api::V1::RatingsController < ApplicationController
  before_action :find_rating, only: [:update, :destroy]

  def index
    ratings = Rating.all
    render json: ratings
  end

  def update
    if @rating.update(rating_params)
      render json: @rating
    else
      render json: { "message": "Could not update rating, please try again" }
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:value, :user_id, :item_id)
  end

  def find_rating
    @rating = Rating.find(params[:id])
  end
end

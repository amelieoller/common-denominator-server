class Api::V1::FriendshipsController < ApplicationController
  def index
    friends = current_user.friends

    if friends
      render json: friends
    else
      render json: { errors: ["Error fetching friends"] }
    end
  end
end

class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create, :show]

  def create
    user = User.find_by(username: params[:username])

    if user
      if user.authenticate(params[:password])
        render json: { user: UserSerializer.new(user), token: issue_token({ user_id: user.id }) }
      else
        render json: { errors: user.errors.full_messages }
      end
    else
      render json: { errors: ["No user found, please try again"] }
    end
  end

  def show
    if current_user
      render json: { user: UserSerializer.new(current_user), token: issue_token({ user_id: current_user.id }) }
    else
      render json: { errors: ["Invalid token"] }, status: 401
    end
  end
end

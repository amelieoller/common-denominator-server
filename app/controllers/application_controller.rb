class ApplicationController < ActionController::API
  before_action :authorized

  def issue_token(payload)
    JWT.encode(payload, ENV["secret"], "HS256")
  end

  def current_user
    @user ||= User.find_by(id: user_id)
  end

  def user_id
    decoded_token.first["user_id"]
  end

  def decoded_token
    begin
      JWT.decode(request.headers["Authorization"], ENV["secret"], true, { :algorithm => "HS256" })
    rescue JWT::DecodeError
      [{}]
    end
  end

  def authorized
    render json: { message: "Not authorized" }, status: 401 unless logged_in?
  end

  def logged_in?
    !!current_user
  end

  def generate_custom_friendship_id(id1, id2)
    lower = [id1, id2].min
    higher = [id1, id2].max

    "#{lower}_#{higher}"
  end
end

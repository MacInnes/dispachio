class Api::V1::LoginController < ActionController::API

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      render json: UserSerializer.new(user).serialized_json
    else
      render status: 401, json: {message: "Incorrect Username or Password"}
    end

  end

end

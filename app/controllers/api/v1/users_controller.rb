class Api::V1::UsersController < ActionController::API

  def create
    user = User.new(user_params)
    if user.save
      user_setup(user)
      render json: UserSerializer.new(user).serialized_json
    else
      render status: 400, json: {message: "Invalid request"}
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password, :role)
  end

  def send_api_key(user)
    RegistrationNotifierMailer.send_key(user).deliver_now
  end

  def user_setup(user)
    user.generate_api_key
    session[:id] = user.id
    session[:api_key] = user.api_key
    send_api_key(user)
  end

end

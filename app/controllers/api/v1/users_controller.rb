class Api::V1::UsersController < ActionController::API

  def create
    user = User.new(user_params)
    if user.save
      user.generate_api_key
      render json: {api_key: user.api_key}
    else
      render json: {status: 400, message: "Invalid request"}
    end
  end

  private

    def user_params
      params.permit(:username, :email, :password, :role)
    end

end

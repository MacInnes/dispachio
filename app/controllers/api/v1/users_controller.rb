class Api::V1::UsersController < ActionController::API

  def create
    user = User.new(user_params)
    if user.save
      # ...
    end
  end

  private

    def user_params
      params.permit(:username, :email, :password, :role)
    end

end

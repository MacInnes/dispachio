class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      redirect_to "/#{user.role}"
    else
      # flash message
      redirect_to "/register"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :role)
  end

end

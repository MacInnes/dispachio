class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      user.generate_api_key
      session[:id] = user.id
      send_api_key(user)
      redirect_to "/#{user.role}"
    else
      redirect_to('/register', notice: 'Invalid registration details.')
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :role)
  end

  def send_api_key(user)
    RegistrationNotifierMailer.send_key(user).deliver_now
  end

end

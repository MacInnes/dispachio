class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      user_setup(user)
      redirect_to "/#{user.role}/#{user.id}"
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

  def user_setup(user)
    user.generate_api_key
    session[:id] = user.id
    send_api_key(user)
  end

end

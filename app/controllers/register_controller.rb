class RegisterController < ApplicationController

  def new
    @user = User.new
  end

end

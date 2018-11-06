class Api::V1::DriverController < ActionController::API

  def show
    if valid_user?
      render json: DriverSerializer.new(@user).serialized_json
    else
      render status: 403, json: {message: "Unauthorized"}
    end
  end

  private

  def valid_user?
    @user ||= User.find_by_api_key(request.headers['X-API-KEY'])
    @user.id == params[:id].to_i || @user.role == 'dispatcher'
  end

end

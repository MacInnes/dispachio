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
    @user ||= User.find(params[:id])
    @user.api_key == request.headers['HTTP_X_API_KEY']
  end

end

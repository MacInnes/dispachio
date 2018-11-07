class Api::V1::DispatcherController < ActionController::API

  def index
    if dispatcher?
      render json: DispatcherSerializer.new(@user).serialized_json
    else
      render status: 403, json: {message: "Unauthorized"}
    end
  end

  private

  def dispatcher?
    @user ||= User.find_by_api_key(request.headers['X-API-KEY'])
    @user.role == 'dispatcher'
  end
end

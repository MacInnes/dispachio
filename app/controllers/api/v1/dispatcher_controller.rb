class Api::V1::DispatcherController < ActionController::API

  def index
    if dispatcher?
      render json: DispatcherSerializer.new(@user).serialized_json
    else
      render status: 403, json: {message: "Unauthorized"}
    end
  end

  def update
    if this_dispatcher?
      @user = User.find(params[:id])
      @user.update(destination: params[:destination])
      render json: DriverSerializer.new(@user).serialized_json
    else
      render status: 403, json: {message: "Unathorized"}
    end
  end

  private

  def dispatcher?
    @user ||= User.find_by_api_key(request.headers['X-API-KEY'])
    @user.role == 'dispatcher'
  end

  def this_dispatcher?
    @user ||= User.find_by_api_key(request.headers['X-API-KEY'])
    @user.id == params[:id].to_i
  end

end

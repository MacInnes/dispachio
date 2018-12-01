class Api::V1::DispatcherController < ActionController::API

  def show
    if dispatcher?
      render json: DispatcherSerializer.new(@user).serialized_json
    else
      render status: 403, json: {message: "Unauthorized"}
    end
  end

  def update
    # is this needed?
    if this_dispatcher?
      @user = User.find(params[:id])
      json = JSON.parse(request.body.read, symbolize_names: true)
      @user.update(destination: json[:destination])
      render json: DispatcherSerializer.new(@user).serialized_json
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

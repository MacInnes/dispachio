class Api::V1::DriverController < ActionController::API

  def show
    if valid_user?
      render json: DriverSerializer.new(@user).serialized_json
    else
      render status: 403, json: {message: "Unauthorized"}
    end
  end

  def update
    if dispatcher?
      @user = User.find(params[:id])
      @user.update(destination: params[:destination])
      render json: DriverSerializer.new(@user).serialized_json
    else
      render status: 403, json: {message: "Unathorized"}
    end
  end

  def index
    if dispatcher?
      drivers = User.where(role: 'driver')
      serialized_drivers = drivers.map do |driver|
        DriverSerializer.new(driver).serialized_json
      end
      render json: serialized_drivers
    else
      render status: 403, json: {message: "Unathorized"}
    end
  end

  def update_location
    if current_driver?
      @user.update(lat: params[:lat], long: params[:long])
      render status: 204, json: ''
    else
      render status: 403, json: {message: 'Unauthorized'}
    end
  end

  private

  def dispatcher?
    @user ||= User.find_by_api_key(request.headers['X-API-KEY'])
    @user.role == 'dispatcher'
  end

  def current_driver?
    @user ||= User.find_by_api_key(request.headers['X-API-KEY'])
    @user.id == params[:id].to_i && @user.role == 'driver'
  end

  def valid_user?
    @user ||= User.find_by_api_key(session[:api_key])
    @user.id == params[:id].to_i || @user.role == 'dispatcher'
  end

end

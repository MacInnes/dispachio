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
    elsif driver? && params[:latitude]
      @user = User.find(params[:id])
      @user.update(latitude: params[:latitude], longitude: params[:longitude])
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

  private

  def dispatcher?
    @user ||= User.find_by_api_key(request.headers['X-API-KEY'])
    @user.role == 'dispatcher'
  end

  def driver?
    @user ||= User.find_by_api_key(request.headers['X-API-KEY'])
    @user.role == 'driver'
  end

  def valid_user?
    @user ||= User.find_by_api_key(request.headers['X-API-KEY'])
    @user.id == params[:id].to_i || @user.role == 'dispatcher'
  end

end

class Api::V1::DriverController < ActionController::API

  def show
    user = User.find(params[:id])
    render json: DriverSerializer.new(user).serialized_json
  end

end

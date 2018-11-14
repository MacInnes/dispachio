class Api::V2::Drivers::LocationController < API::ApiController

  def update
    current_driver.update(lat: params[:lat], long: params[:long])
  end

end

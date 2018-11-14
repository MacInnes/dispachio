class Api::V2::DriversController < API::ApiController

  def create
    driver = Driver.new(driver_params)
    if driver.save
      driver_setup(driver)
      render json: {api_key: driver.api_key}
    else
      render status: 400, json: {message: "Invalid request"}
    end
  end

  def show
    if current_driver
      render json: DriverSerializer.new(current_driver).serialized_json
    else
      render status: 404, json: {message: "Driver not found"}
    end
  end

  private

  def driver_params
    params.permit(:username, :email, :password)
  end

  def send_api_key(driver)
    RegistrationNotifierMailer.send_key(driver).deliver_now
  end

  def driver_setup(driver)
    driver.generate_api_key
    session[:id] = driver.id
    send_api_key(driver)
  end

end

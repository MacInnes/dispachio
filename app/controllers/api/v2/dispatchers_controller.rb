class Api::V2::DispatchersController < ActionController::API

  def create
    dispatcher = Dispatcher.new(dispatcher_params)
    if dispatcher.save
      dispatcher_setup(dispatcher)
      render json: {api_key: dispatcher.api_key}
    else
      render status: 400, json: {message: "Invalid request"}
    end
  end

  private

  def dispatcher_params
    params.permit(:username, :email, :password)
  end

  def send_api_key(dispatcher)
    RegistrationNotifierMailer.send_key(dispatcher).deliver_now
  end

  def dispatcher_setup(dispatcher)
    dispatcher.generate_api_key
    session[:id] = dispatcher.id
    send_api_key(dispatcher)
  end

end

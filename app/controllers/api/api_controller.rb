class API::ApiController < ActionController::API

protected

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render status: 403, json: {body: "Unauthenticated"}
  end

  def current_driver
    @current_driver ||= Driver.find_by_api_key!(request.headers['X-API-KEY'])
  end

end

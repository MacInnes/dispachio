class API::ApiController < ActionController::API

protected
  def current_user
    @current_user ||= User.find_by_api_token!(headers[:api_token])
  rescue ActiveRecord::NotFound
    render status: 403, body: 'Unauthenticated'
  end

  def current_driver
    @current_user ||= User.find_by_api_token!(headers[:api_token])
  rescue ActiveRecord::NotFound
    render status: 403, body: 'Unauthenticated'
  end
end

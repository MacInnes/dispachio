require 'securerandom'

class User < ApplicationRecord
  has_secure_password

  enum role: ['driver', 'dispatcher']

  def generate_api_key
    update(api_key: SecureRandom.urlsafe_base64) unless api_key
  end

  def formatted_destination
    uri = self.destination.gsub(/ /, '+')
    "https://www.google.com/maps/embed/v1/place?key=#{ENV['GOOGLE_MAPS_API_KEY']}&q=#{uri}"
  end

  def drivers
    User.where(role: 'driver')
  end

end

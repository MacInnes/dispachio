require 'securerandom'

class Driver < ApplicationRecord
  has_secure_password

  def generate_api_key
    update(api_key: SecureRandom.urlsafe_base64) unless api_key
  end

end

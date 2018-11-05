require 'securerandom'

class User < ApplicationRecord
  has_secure_password

  enum role: ['driver', 'dispatcher']

  def generate_api_key
    update(api_key: SecureRandom.urlsafe_base64) unless api_key
  end
end

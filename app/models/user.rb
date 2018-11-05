class User < ApplicationRecord
  has_secure_password

  enum role: ['Driver', 'Dispatcher']
end

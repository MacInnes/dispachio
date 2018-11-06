class DriverSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username, :email

  attribute :formatted_destination do |object|
    object.destination.gsub(/ /, '+')
  end
end

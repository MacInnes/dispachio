class DriverSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username, :email, :destination, :lat, :long

  attribute :formatted_destination do |object|
    uri = object.destination.gsub(/ /, '+')
    "https://www.google.com/maps/embed/v1/place?key=#{ENV['GOOGLE_MAPS_API_KEY']}&q=#{uri}"
  end

  attribute :formatted_location do |object|
    "https://www.google.com/maps/embed/v1/place?key=#{ENV['GOOGLE_MAPS_API_KEY']}&q=#{object.lat},#{object.long}"
  end
end

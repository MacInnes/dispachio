class DriverSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username, :email, :destination

  attribute :formatted_destination do |object|
    if object.destination
      uri = object.destination.gsub(/ /, '+')
      "https://www.google.com/maps/embed/v1/place?key=#{ENV['GOOGLE_MAPS_API_KEY']}&q=#{uri}"
    end
  end
end

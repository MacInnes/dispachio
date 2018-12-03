# Dispachio

Dispachio is an app that connects Dispatchers with their Drivers, and allows Dispatchers to view a Driver's location and send them new destinations.  [Here](https://dispachio.herokuapp.com/) is a deployed example on Heroku.  The core of the app is an API containing the following endpoints (data is returned in JSON format):

`POST '/api/v1/login' - this endpoint allows a user to login with just their username and password`

`GET '/api/v1/drivers' - this endpoint lists all Drivers who were updated within the last minute`

`GET '/api/v1/drivers/:id' - this endpoint lists information for a specific Driver (only that Driver or a Dispatcher have access)`

`POST '/api/v1/drivers/:id/destination' - this endpoint can only be used by a Dispatcher, and it updates a Driver's destination`

`GET '/api/v1/drivers/:id/location' - this endpoint provides a Dispatcher with a Driver's location`

`POST '/api/v1/drivers/:id/location' - this endpoint updates a Driver's location (only that Driver has access)`

`GET '/api/v1/dispatchers/:id' - this endpoint provides data about a specific Dispatcher`

`POST '/api/v1/dispatchers/:id/destination' - this endpoint updates the destination of a Dispatcher (used to cache most recent Destination searched)`

Technologies used in the API:

* Ruby '2.4.1'

* Rails '5.2.1'

* RSpec

* Fast JSON API

* Google MAPS API

In addition to the API, this repository includes an example Front End to demonstrate how this API can be used.  A Google Maps API Key is required to use this example, you can sign up for one [here](https://developers.google.com/maps/documentation/embed/get-api-key).  Simply store this key as an Environment variable under the name `GOOGLE_MAPS_API_KEY`.

Once you have a Google Maps API Key, simply clone down this repository.  Run `bundle install`, followed by `rake db:{create,migrate}`.  If everything is setup correctly, you should be able to start the server by running `rails s` from the command line.

This example app has 2 main pages once you've registered / logged in: one for Drivers and one for Dispatchers.  The Dispatcher page contains a searchable map as well as two lists of active Drivers - one for getting the location of a Driver and one for setting the Destination of a Driver.  The Dispatcher page makes a request to `GET /api/v1/drivers` every 10 seconds to ensure the list of active Drivers is up to date.  On the Driver's page, there is simply an embedded map.  The Driver page makes a request every 5 seconds to update its location and check for updates to its destination.  If the destination has been updated, the map will automatically re-render with the new address.  

This project was built by [Andrew Mockett](https://github.com/MacInnes) for the Turing school of Software and Design.  This project is a work in progress, please let me know if you find any issues or are interested in contributing!

function setAddress(driverId){
  var address = $('#dispatcher-destination').val();
  fetch(`/api/v1/drivers/${driverId}/destination`, {
    method: 'post',
    headers: {
      'X-API-KEY': localStorage.api_key,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      destination: address
    })
  })
  .then(response => response.json())
  .then(data => console.log(data))
  // send a message to dispatch that the location was sent properly on success
}

function findAddress(){
  var address = $('#dispatcher-destination').val();
  fetch(`/api/v1/dispatchers/${localStorage.id}/destination`, {
    method: 'post',
    headers: {
      'X-API-KEY': localStorage.api_key,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      destination: address
    })
  })
  .then(response => response.json())
  .then(addressData => renderAddress(addressData))
  .catch(error => console.log(error));
}

function renderAddress(address){
  var new_destination = address.data.attributes.formatted_destination
  var destination = address.data.attributes.destination
  $('#dispatch-destination').text(`'Map for ${destination}:`)
  $('#dispatcher-iframe').attr('src', new_destination)
}

function renderLocation(location){
  console.log(location)
  var current_location = location.data.attributes.formatted_location
  var driver_name = location.data.attributes.username
  $('#dispatch-destination').text(`Location of ${driver_name}: ${location.data.attributes.lat}, ${location.data.attributes.long}`)
  $('#dispatcher-iframe').attr('src', current_location)
}

function getDrivers(){
  fetch('/api/v1/drivers', {
    headers: {
      'Content-Type': 'application/json',
      'X-API-KEY': localStorage.api_key
    }
  })
  .then(response => response.json())
  .then(drivers => createDriverList(drivers));
}

function createDriverList(driver_array){
  $('.drivers').empty();
  $('.location').empty();
  console.log(driver_array)
  var json_converted_drivers = driver_array.map(function(driver){
    return JSON.parse(driver);
  });
  json_converted_drivers.forEach(function(driver){
    $('.drivers').append(`<div><button class='driver-button' type='button' value='${driver.data.id}'>${driver.data.attributes.username}</button></div>`)
    $('.location').append(`<div><button class='location-button' type='button' value='${driver.data.id}'>${driver.data.attributes.username}</button></div>`)
  })
}

function getLocation(id){
  fetch(`/api/v1/drivers/${id}/location`, {
    headers: {
      'Content-Type': 'application/json',
      'X-API-KEY': localStorage.api_key
    }
  })
    .then(response => response.json())
    .then(driver => renderLocation(driver))
    .catch(error => console.log(error))
}

getDrivers();

$('#dispatch-submit').click(function(){
  findAddress();
});

$('#dispatcher-destination').keydown(function(e){
  if (e.which == 13){
    findAddress();
  }
})

$('.drivers').on('click', ".driver-button", function(event){
  driver_id = $(this).val();
  setAddress(driver_id);
});

$('.location').on('click', '.location-button', function(event){
  driver_id = $(this).val();
  getLocation(driver_id);
})

setInterval(getDrivers, 10000);

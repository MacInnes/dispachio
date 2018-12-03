function getDestination(){
  fetch(`/api/v1/drivers/${localStorage.id}`, {
    headers: { 'X-API-KEY': localStorage.api_key }
  })
    .then(response => response.json())
    .then(json => renderDestination(json))
    .catch(error => console.log(error))
}

function renderDestination(data){
  var newDestination = data.data.attributes.formatted_destination
  var destination = data.data.attributes.destination
  if (compareDestination(newDestination)){
    $('#driver-destination').text('Directions to ' + destination + ':')
    $('#driver-iframe').attr('src', newDestination)
  }
}

function compareDestination(newDestination){
  currentDestination = $('#driver-iframe').attr('src');
  return currentDestination != newDestination;
}

function getLocation(){
  navigator.geolocation.getCurrentPosition(setLocation);
}

function setLocation(location){
  console.log(location.coords.latitude, location.coords.longitude)
  fetch(`/api/v1/drivers/${localStorage.id}/location`, {
    method: 'post',
    headers: {
      'Content-Type': 'application/json',
      'X-API-KEY': localStorage.api_key
    },
    body: JSON.stringify({
      lat: location.coords.latitude,
      long: location.coords.longitude
    })
  })
}

function testing(loc){
  console.log(loc)
}

getDestination();

setInterval(getDestination, 5000);
setInterval(getLocation, 5000);

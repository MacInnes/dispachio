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

getDestination();

setInterval(getDestination, 10000);

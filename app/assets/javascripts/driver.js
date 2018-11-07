function getDestination(){
  $.ajax({
    dataType: "json",
    url: '/api/v1/drivers/' + driver_id + '/destination',
    headers: {
      'X-API-KEY': api_key
    },
    ifModified: true,
    success: function(data){
      if (data){
        var new_destination = data.data.attributes.formatted_destination
        var destination = data.data.attributes.destination
        $('#driver-destination').text('Directions to ' + destination + ':')
        $('#driver-iframe').attr('src', new_destination)
      }
    },
    error: function(){
      console.log('error occurred!!')
    }
  });
};

function success(pos) {
  var crd = pos.coords;

  $.ajax({
    method: 'POST',
    dataType: 'json',
    contentType: 'application/json',
    headers: {
      'X-API-KEY': api_key
    },
    url: '/api/v1/drivers/' + driver_id + '/location',
    data: JSON.stringify({
     latitude: crd.latitude,
     longitude: crd.longitude
    }),
    success: function(data){
      console.log('Location sent.')
    }
  })
}

function error(err) {
  console.warn(`ERROR(${err.code}): ${err.message}`);
}

function getLocation(){
  navigator.geolocation.getCurrentPosition(success, error);
};

getDestination();
getLocation();

setInterval(getDestination, 10000);

setInterval(getLocation, 60000);

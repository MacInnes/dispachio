function getDestination(){
  $.ajax({
    method: "POST",
    dataType: "json",
    url: '/api/v1/drivers/' + driver_id + '/destination',
    headers: {
      'X-API-KEY': api_key
    },
    data:
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

getDestination();

setInterval(getDestination, 10000);

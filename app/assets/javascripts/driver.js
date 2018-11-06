function loop() {
  console.log(api_key);
  console.log(driver_id);
  getDestination();
  setInterval(loop, 10000);
}

function getDestination(){
  $.ajax({
    dataType: "json",
    url: '/api/v1/drivers/' + driver_id + '/destination',
    headers: {
      'X-API-KEY': api_key
    },
    success: function(data){
      $('#driver-iframe').attr('src', data.data.attributes.formatted_destination)
    }
  });
}

loop();

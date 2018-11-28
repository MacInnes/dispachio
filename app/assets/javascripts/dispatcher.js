function setAddress(driver_id){
  var address = $('#dispatcher-destination').val();
  $.ajax({
    method: 'POST',
    dataType: "json",
    contentType: 'application/json',
    headers: {
      'X-API-KEY': window.api_key
    },
    url: '/api/v1/drivers/' + driver_id + '/destination',
    data: JSON.stringify({
     destination: address
    }),
    success: function(data){
      if (data){
        console.log(data);
      }
    },
  })
}

function findAddress(){
  var address = $('#dispatcher-destination').val();
  $.ajax({
    method: 'POST',
    dataType: "json",
    contentType: 'application/json',
    headers: {
      'X-API-KEY': window.api_key
    },
    url: '/api/v1/dispatchers/' + window.dispatcher_id + '/destination',
    data: JSON.stringify({
     destination: address
    }),
    success: function(data){
      if (data){
        var new_destination = data.data.attributes.formatted_destination
        var destination = data.data.attributes.destination
        $('#dispatch-destination').text('Directions to ' + destination + ':')
        $('#dispatcher-iframe').attr('src', new_destination)
      }
    },
  })
}

function getDrivers(){
  $.ajax({
    dataType: 'json',
    headers: {
      'X-API-KEY': window.api_key
    },
    async: false,
    url: '/api/v1/drivers',
    success: function(data){
      createDriverList(data);
    }
  })
}

function createDriverList(driver_array){
  var json_converted_drivers = driver_array.map(function(driver){
    return JSON.parse(driver);
  });
  json_converted_drivers.forEach(function(driver){
    $('.drivers').append("<div><button class='driver-button' type='button' value='" + driver.data.id + "'>" + driver.data.attributes.username + "</button></div>")
  })
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

$('.driver-button').click(function(){
  console.log('CLICKED')
  driver_id = $(this).val();
  console.log(driver_id);
  setAddress(driver_id);
})

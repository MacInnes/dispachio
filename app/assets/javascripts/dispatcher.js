$('#dispatch-submit').click(function(){
  findAddress();
});

$('#dispatcher-destination').keydown(function(e){
  if (e.which == 13){
    findAddress();
  }
})

$('.driver-button').click(function(){
  driver_id = $(this).val();
  setAddress(driver_id);
})

function setAddress(driver_id){
  var address = $('#dispatcher-destination').val();
  console.log(address)
  $.ajax({
    method: 'POST',
    dataType: "json",
    contentType: 'application/json',
    headers: {
      'X-API-KEY': api_key
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
  console.log(address)
  $.ajax({
    method: 'POST',
    dataType: "json",
    contentType: 'application/json',
    headers: {
      'X-API-KEY': api_key
    },
    url: '/api/v1/dispatchers/' + dispatcher_id + '/destination',
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

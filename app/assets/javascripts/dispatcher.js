$('#dispatch-submit').click(function(){
  findAddress();
});

$('#dispatch-address').keyup(function(e){
  if(e.keyCode == 13)
  {
    findAddress();
  }
});

function findAddress(address){
  var address = $('#dispatch-address').val();
  $.ajax({
    method: 'POST',
    dataType: "json",
    headers: {
      'X-API-KEY': api_key
    },
    url: '/api/v1/dispatchers/' + dispatcher_id + '/destination',
    data: {
      destination: address
    },
    success: function(data){
      if (data){
        var new_destination = data.data.attributes.formatted_destination
        var destination = data.data.attributes.destination
        $('#dispatcher-destination').text('Directions to ' + destination + ':')
        $('#dispatcher-iframe').attr('src', new_destination)
      }
    },
  })
}

function getInitialMap(){
  $.ajax({
    dataType: "json",
    url: '/api/v1/dispatcher',
    headers: {
      'X-API-KEY': api_key
    },
    success: function(data){
      if (data){
        map = data.data.attributes.initial_map
        $('#dispatcher-iframe').attr('src', map)
      }
    },
    error: function(){
      console.log('error occurred!!')
    }
  });
};

$('#dispatch-submit').click(function(){
  var address = $('#dispatch-address').val();
  console.log(address);
});

getInitialMap();

console.log('DISPACHIO')

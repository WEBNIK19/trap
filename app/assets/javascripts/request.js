// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

Pusher.logToConsole = true;

var pusher = new Pusher('86987ac565e812024804', {
  cluster: 'eu',
  encrypted: true
});
$(document).ready(function (){
    var trap_id = $('h1').html();
    var channel = pusher.subscribe(trap_id);
    
    channel.bind('new-request', function(data) {
      $('#requests').prepend('<tr><td>'+
        data.method  
        +'</td><td>'+
        data.remote_ip
        +'</td><td>'+
        data.scheme
        +'</td><td>'+
        data.params
        +'</td><td>'+
        data.created_at
        +'</td><td><a href="/firefox/requests/'+
        data.request_id
        +'" class="btn btn-default">More</a></td></tr>')
  });
})

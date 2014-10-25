$(document).on('ready page:load', function () {
  $('#transfert_button').click(function(){ 
    host = "http://92.222.1.55";
    if(window.location.hostname == "localhost") {
      host = "http://localhost"
    }

    $.ajax( { type: "PUT",
              url: host+":3002/images/transfert.json" })
      .done(function() {
        alert( "Transfert success" );
      })
      .fail(function() {
        alert( "Transfert error" );
      })
  });
});
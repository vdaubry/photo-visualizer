$(document).on('ready page:load', function () {
  $('#transfert_button').click(function(){ 
    $.ajax( { type: "PUT",
              url: "http://92.222.1.55:3002/images/transfert.json" })
      .done(function() {
        alert( "Transfert success" );
      })
      .fail(function() {
        alert( "Transfert error" );
      })
  });
});
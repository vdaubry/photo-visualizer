$(document).ready(function(){
	$('#destroy_all_link').click(function(){ 
		
		$('.list_image').each(function( index ) {
		  if($(this).attr('data')==null) {
		  	var input = $("<input>")
               .attr("type", "hidden")
               .attr("name", "image[ids][]").val($(this).attr('id'));
			$('#destroy_all_form').append($(input));
		  }
		});

		
		$('#destroy_all_form').submit();
	});
});
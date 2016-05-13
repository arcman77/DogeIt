// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.



$(document).ready(function(){

	var takePicture = $('#upload_file');

	takePicture.change(function(event) {
		$('#post_button').removeClass('disabled');
		$('#caption_box').attr('placeholder', 'Caption It!');
		$('#caption_box').removeClass('no_display');
		$('#caption_box').addClass('yes_display');
	});
  var id = getPhotoId();
  if(id){
    console.log("we're in business");
    deleteYourStupidPhoto(id);
  }
});

function getPhotoId(){
  var url = window.location.href;
  id = url.split('=')[1];
  return id;
}

function deleteYourStupidPhoto(id){
  var current_url = window.location.href;
  var protocol    = current_url.split('/')[0]
  var domain      = current_url.split('/')[2];
  console.log
  var request = $.ajax({
    type: "DELETE",
    url:  protocol + '//' + domain + '/photo/'+id
  });
  request.done(function (response){
    console.log(response);
  })
}
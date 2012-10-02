function initLayout(){
  var window_width = $(window).width();
  wrapper_width = Math.floor( window_width / 236 ) * 236;
  if ( window_width > 960 ) {
    $('.wrapper').css("width", wrapper_width + "px" );
  } else {
    $('.wrapper').css("width", "944px" );
  }
}

function resort(){
  $('#cuties').masonry({
    itemSelector : '.item',
    isResizable: false
  });
}

$(function(){
	// delay for masonry to load.
	initLayout();
	setTimeout(function() {
		resort();		
	}, 300);
	
	$('.item .img-wrap').hover(function() {
		$(this).find(".item-details").show();
	}, function() {
		$(this).find(".item-details").hide();		
	});
});

$(window).resize(function(){
  initLayout();
  resort();
});
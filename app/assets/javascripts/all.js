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
	$('#cuties, .item img').imagesLoaded( function( $images, $proper, $broken ) {
		console.log( $images.length + ' images total have been loaded' );
		//console.log( $proper.length + ' properly loaded images' );
		//console.log( $broken.length + ' broken images' );
		resort();	
	});
	
	// delay for masonry to load.
	initLayout();
	resort();		
	/*setTimeout(function() {
		resort();		
	}, 500);*/
	
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
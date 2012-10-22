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
	initLayout();

	$container = $('#cuties');
	$container.imagesLoaded(function() {
		resort();	
	});
	
	resort();		
	
	$('.item .img-wrap').hover(function() {
		$(this).find(".item-details").show();
	}, function() {
		$(this).find(".item-details").hide();		
	});	
	
	$container.infinitescroll({
		navSelector  : '#page-nav',    // selector for the paged navigation 
	  nextSelector : '#page-nav a',  // selector for the NEXT link (to page 2)
    itemSelector : '.item',     // selector for all items you'll retrieve
    loading: {
        finishedMsg: 'No more pages to load.',
        img: 'http://i.imgur.com/6RMhx.gif'
      }
    },
    // trigger Masonry as a callback
    function( newElements ) {
      // hide new items while they are loading
      var $newElems = $( newElements ).css({ opacity: 0 });
      // ensure that images load before adding to masonry layout
      $newElems.imagesLoaded(function(){
        // show elems now they're ready
        $newElems.animate({ opacity: 1 });
        $container.masonry( 'appended', $newElems, true ); 
      });
    }
  );

	$(window).scroll(function(){
		if ($(this).scrollTop() > 100) {
			$('.scrollup').fadeIn();
		} else {
			$('.scrollup').fadeOut();
		}
	}); 

	$('.scrollup').click(function(){
		$("html, body").animate({ scrollTop: 0 }, 600);
		return false;
	});
	
	$(".item a").live('click', function(e) {
		e.preventDefault();
		//console.log(this.href);
	  var str = $('<img src="/images/loading.gif" class="modal-loading" title="loading..." alt="loading..."/>');
		bootbox.modal(str, { backdrop : true, header : true, headerCloseButton : true });
		$('.modal-body').load(this.href + " #photo-container", function(response, status, xhr) {
			//console.log(response);
			//str.html(response);
		});
	});
	$('body').tooltip({
	    selector: '[rel=tooltip]'
	});
});

$(window).resize(function(){
  initLayout();
  resort();
});

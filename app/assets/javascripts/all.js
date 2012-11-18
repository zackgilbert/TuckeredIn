// global storing of variables
var modal = null; // allow for only 1 modal window

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

  $(".item a, .modal-nav a").live('click', function(e) {
    e.preventDefault();
    //console.log(this.href);
    var str = $('<img src="/images/loading.gif" class="modal-loading" title="loading..." alt="loading..."/>');
    var link = this.href;
    if (!modal || !modal.modal) {
      modal = bootbox.modal(str, { backdrop : true, header : true, headerCloseButton : true });
    } else {
      modal.modal('show');
    }
    $('.modal-body').load(link, function(response, status, xhr) {
      // lets actually track this page load in analytics so we know what's being loaded.
      var domain = link.split('/')[2];
      var page = link.substr("http://".length + domain.length);
      _gaq.push(['_trackPageview', page]);
      // change browser address bar.
      if (link != window.location) {
        if (typeof window.history.pushState == 'function') window.history.pushState({ path: link }, '', link);
      }
    });
    setModalNav(link);
    modal.unbind("hidden"); // cancel already potentially existing hide callback, so we don't add an additional /home to history
    modal.on("hidden", function() {  // remove the actual elements from the DOM when fully hidden
      if (typeof window.history.pushState == 'function') window.history.pushState({ path: '/' }, '', '/');
    });

  });

  $(window).bind('popstate', function(ev) {
    if (!window.history.ready && !ev.originalEvent.state) {
      window.history.ready = true;
      return; // workaround for popstate on load
    }

    handleModal();
  });

  $('body').tooltip({
      selector: '[rel=tooltip]'
  });

  setTimeout(function(){ handleModal() }, 1000);
});

function setModalNav(link) {
  //console.log($("a[href='" + options['nav'] + "']:first").get(0));
  var prev = $("a[href='" + link + "']:first").parent().parent().prev().find('a').get(0);
  var next = $("a[href='" + link + "']:first").parent().parent().next().find('a').get(0);
  var nav = '';
  if (prev) nav += '<a href="' + prev.href + '" class="modal-nav-prev"></a>';
  if (next) nav += '<a href="' + next.href + '" class="modal-nav-next"></a>';
  $('.modal-nav').html(nav);
}

function handleModal() {
  window.history.ready = true;
  if (window.location.href.indexOf('/cuties/') > 0) {
    //console.log('changed...');
    var str = $('<img src="/images/loading.gif" class="modal-loading" title="loading..." alt="loading..."/>');
    if (!modal || !modal.modal) {
      modal = bootbox.modal(str, { backdrop : true, header : true, headerCloseButton : true });
    } else {
      modal.modal('show');
    }
    $('.modal-body').load(window.location.href);
    setModalNav(window.location.href);
    modal.unbind("hidden"); // cancel already potentially existing hide callback, so we don't add an additional /home to history
    modal.on("hidden", function() {  // remove the actual elements from the DOM when fully hidden
      if (typeof window.history.pushState == 'function') {
        //console.log(window.history);
        window.history.pushState({ path: "/" }, '', "/");
      }
    });
  } else {
    if (modal && modal.modal) {
      modal.unbind("hidden"); // cancel already potentially existing hide callback, so we don't add an additional /home to history
      modal.modal('hide');
    }
  }
}

$(window).resize(function(){
  initLayout();
  resort();
});

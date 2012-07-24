$(function() {
	$('.utilities a.like').bind('click', function(e) {
		e.preventDefault();
		var link = this;
		var href = $(link).attr('href');
		var method = ($(link).hasClass('selected')) ? "DELETE" : "POST";
		
		$.ajax({
			url: href,
		  type: method,
		  dataType: 'json',
		  data: {},
		  success: function(data) {
				$(link).parent().parent().find('.likes .value').html(data);
				if (method == 'DELETE') {
					$(link).attr('href', href.replace('unlike', 'like'));
					$(link).removeClass('selected');
				} else {
					$(link).attr('href', href.replace('like', 'unlike'));
					$(link).addClass('selected');
				}
		  }
		});
	});
});
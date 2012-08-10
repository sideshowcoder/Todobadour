notice = "<div>Email sent</div>"

jQuery ($) ->
	$('#sender').val ""
	$('#receiver').val ""
	$('#message').val ""
	$( notice ).purr fadeInSpeed: 200, fadeOutSpeed: 2000, removeTimer: 5000
	
	
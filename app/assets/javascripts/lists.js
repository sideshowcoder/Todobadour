$(function(){
	// subscribe to messages for the current active list
	var faye = new Faye.Client(window.fayeURL);
	faye.subscribe(window.location.pathname, function(data){
		console.log(data);
		eval(data);
	});	
})
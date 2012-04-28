
$(function(){
	
	// handle the updating of a todo changed by best_in_place
	function update_todo(d){
		// update the todo title
		$('#best_in_place_todo_' + d.id + '_title').html(d.title);
		// get done and not done tags 
		var done = $('#best_in_place_todo_' + d.id + '_done');
		var tags = done.data('collection');
		d.done ? done.html(tags[1]) : done.html(tags[0])
	}
	
	// subscribe to messages for the current active list
	var faye = new Faye.Client(window.fayeURL);
	faye.subscribe(window.location.pathname, function(data){
		try {
			// json from a update via best in place
			var d = JSON.parse(data);
			update_todo(d)
		} catch(err) {
			// create a new todo or delete one
			eval(data);
		}
	});	
})
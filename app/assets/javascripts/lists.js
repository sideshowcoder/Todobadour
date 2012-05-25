var list = {};

list.initSortable = function(){
	// Make list sortable if the user hovers over it
	$('#todo-list').sortable({
		update: function(event, ui){
			$.ajax({
			  type: 'PUT',
			  dataType: 'script',
			  data: { list: { todos: $('#todo-list').sortable('toArray') } }, 
			});
		}
	});
	$("#todo-list").disableSelection();	
};

list.initBestInPlace = function(){
	$('.best_in_place', $('#todo-list')).best_in_place();
};

list.pushedUpdate = function(data){
	try {
		// Handle Best in Place update via JSON

		var d = JSON.parse(data);
		// update the todo title
		$('#best_in_place_todo_' + d.id + '_title').html(d.title);
		// get done and not done tags 
		var done = $('#best_in_place_todo_' + d.id + '_done');
		var tags = done.data('collection');
		d.done ? done.html(tags[1]) : done.html(tags[0])		

	} catch (err) {
		// Handle all other Updates via pushed HTML
		$('#todo-list').replaceWith(data);		
	}

	// Reinit editing after update
	list.initBestInPlace()
	list.initSortable();
};

$(function(){
	// Initialize List as sortable
	list.initSortable();
	// Best in place initialized via Main Site
		
	// subscribe to messages for the current active list
	var faye = new Faye.Client(FAYE_URL);
	if (window.location.pathname.match('lists')) {		
		faye.subscribe(window.location.pathname, function(data){
			list.pushedUpdate(data);
		});	
	}
})
var list = {};

list.makeSortable = function(){
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

// handle the updating of a todo changed by best_in_place
list.updateTodo = function(d){
	// update the todo title
	$('#best_in_place_todo_' + d.id + '_title').html(d.title);
	// get done and not done tags 
	var done = $('#best_in_place_todo_' + d.id + '_done');
	var tags = done.data('collection');
	d.done ? done.html(tags[1]) : done.html(tags[0])
};

$(function(){
	// Initialize List as sortable
	list.makeSortable();
		
	// subscribe to messages for the current active list
	var faye = new Faye.Client(FAYE_URL);
	faye.subscribe(window.location.pathname, function(data){
		try {
			// json from a update via best in place
			var d = JSON.parse(data);
			list.updateTodo(d)
		} catch(err) {
			// create a new todo or delete one
			eval(data);
		}
	});	
})
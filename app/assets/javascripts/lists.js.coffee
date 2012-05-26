jQuery ($) ->

	class List
		constructor: (@id) ->
	
		current_list: ->
			$(@id)
	
		asSortable: ->
			that = this
			@current_list().sortable update: (event, ui) ->
				$.ajax 
					type: 'PUT'
					dataType: 'script'
					data: list:
						todos: that.current_list().sortable 'toArray'
			do @current_list().disableSelection
			
		asBestInPlace: ->
			do $('.best_in_place', @current_list()).best_in_place
			
		update: (data) ->
			try
				d = JSON.parse data
				$("#best_in_place_todo_#{d.id}_title").html d.title
				done = $("#best_in_place_todo_#{d.id}_done")
				tags = done.data('collection');
				if d.done
					done.html tags[1]
				else
					done.html tags[0]		
			catch error
				@current_list().replaceWith data
			
			do @asBestInPlace
			do @asSortable
				
	list = new List '#todo-list'	
	do list.asSortable
	
	if LIST_ID? 
		pusher = new Pusher(PUSHER_KEY)
		channel = pusher.subscribe LIST_ID
		channel.bind 'list_update', (data) ->
			list.update data
	

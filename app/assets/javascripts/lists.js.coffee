root = exports ? this

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
					data:
						list:
							todos: that.current_list().sortable 'toArray'
			do @current_list().disableSelection
		
		asBestInPlace: ->
			do $('.best_in_place', @current_list()).best_in_place
		
		addTodo: (data) ->
			@current_list().prepend(data)
			do @asBestInPlace
			do @asSortable
		
		removeTodo: (data) ->
			$(data).remove()
			do @asBestInPlace
			do @asSortable
		
		updateTodo: (data) ->
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
				error			
			do @asBestInPlace
			do @asSortable	
		
		reorder: (data) ->
			@current_list().replaceWith data			
			do @asBestInPlace
			do @asSortable
		
			
	if LIST_ID? 
		socket_id = ""
		root.list = list = new List '#todo-list', socket_id
		do list.asSortable

		pusher = new Pusher(PUSHER_KEY)
		channel = pusher.subscribe LIST_ID
		
		pusher.connection.bind 'connected', ->
			$.ajaxSetup
				data:
					socket_id: pusher.connection.socket_id

		channel.bind 'add_todo', (data) ->
			list.addTodo data
			
		channel.bind 'remove_todo', (data) ->
			list.removeTodo data

		channel.bind 'update_todo', (data) ->
			list.updateTodo data
		
		channel.bind 'reorder_list', (data) ->
			list.reorder data
		
			
<% publish @list.slug, "add_todo", @socket_id do %>
	<%= render @todo %>
<% end %>

jQuery ($) ->
	list.addTodo '<%=escape_javascript render @todo %>'
	$('#todo_title').val ''
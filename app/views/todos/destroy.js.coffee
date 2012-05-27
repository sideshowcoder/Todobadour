<% publish @list.slug, "remove_todo", @socket_id do %>
	<%= "\#todo_#{@removeId}" %>
<% end %>

jQuery ($) ->
	list.removeTodo '<%=escape_javascript "\#todo_#{@removeId}" %>'
	$('#todo_title').val ''
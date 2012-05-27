<% publish @list.slug, "reorder_list", @socket_id do %>
	<%= render :partial => "lists/todolist", :locals => { :todos => @list.ordered_todos } %>
<% end %>

jQuery ($) ->
	list.reorder '<%=escape_javascript render :partial => "lists/todolist", :locals => { :todos => @list.ordered_todos } %>'

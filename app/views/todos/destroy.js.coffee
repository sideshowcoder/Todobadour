<% publish @list.slug, "list_update" do %>
	<%= render( :partial => "lists/todolist", :locals => { :todos => @list.ordered_todos }) %>
<% end %>
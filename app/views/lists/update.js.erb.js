<% publish @list.slug, "reorder" do %>
	<%= render :partial => "lists/todolist", :locals => { :todos => @list.ordered_todos } %>
<% end %>

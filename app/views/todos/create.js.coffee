<% publish @list.slug, "add" do %>
	<%= render @todo %>
<% end %>

jQuery ($) ->
	$('#todo_title').val ''
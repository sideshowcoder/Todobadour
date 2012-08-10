<% if object.errors.any? %>
  <% object.errors.full_messages.each do |msg| %>
    jQuery ($) ->
      notice = "<div>#{"<%= msg %>"}</div>"
      $( notice ).purr fadeInSpeed: 200, fadeOutSpeed: 2000, removeTimer: 5000
  <% end %>                     
<% end %>
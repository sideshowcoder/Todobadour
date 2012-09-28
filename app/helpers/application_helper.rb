module ApplicationHelper
  # Load Facebook Share
  include FacebookShare
  
  # Make the title configurable and available everywhere
  def page_title
    title = content_for?(:title) ? " - #{content_for(:title)}" : ""
    "Todobadour#{title}"
  end

  def page_heading(text)
    content_tag(:h1, content_for(:title){ text })
  end

  # check if we passed a list if not create a new one
  def list
    @list.nil? ? List.new : @list
  end

  # publish a message given as a block
  def publish(channel, event, &block)
    FayeMessage.new.publish(event, channel, capture(&block))
  end

  # js url to include the faye js
  def faye_js
    FayeMessage.new.faye_js_url
  end

  def faye_server
    FayeMessage.new.faye_server
  end

    
end

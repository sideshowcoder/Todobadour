module ApplicationHelper
  # Load Facebook Share
  include FacebookShare
  
  # Make the title configurable and available everywhere
  def title
    base_name = "Todobadour"
    @title.nil? ? base_name : "#{base_name} : #{@title}"
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

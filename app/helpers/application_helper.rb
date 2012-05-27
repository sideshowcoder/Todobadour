module ApplicationHelper
  
  # Make the title configurable and available everywhere
  def title
    base_name = "Todobadour"
    @title.nil? ? base_name : "#{base_name} : #{@title}"
  end
  
  # Broadcast a message via Pusher
  def publish channel, event, exclude, &block
    broadcast channel, event, capture(&block), exclude
  end
  
  def broadcast channel, event, message, exclude
    Pusher[channel].trigger event, message, exclude
  end
    
end

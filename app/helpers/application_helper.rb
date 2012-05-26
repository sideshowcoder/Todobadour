module ApplicationHelper
  
  # Make the title configurable and available everywhere
  def title
    base_name = "Todobadour"
    @title.nil? ? base_name : "#{base_name} : #{@title}"
  end
  
  # Broadcast a message via Pusher
  def publish channel, event, &block
    broadcast channel, event, capture(&block)
  end
  
  def broadcast channel, event, message
    Pusher[channel].trigger event, message
  end
    
end

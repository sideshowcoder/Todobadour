module ApplicationHelper
  
  # Make the title configurable and available everywhere
  def title
    base_name = "Todobadour"
    @title.nil? ? base_name : "#{base_name} : #{@title}"
  end
    
  # Broadcast a message via Faye
  def publish channel, event, &block
    broadcast channel, event, capture(&block)
  end
  
  def broadcast channel, event, message
    message = { channel: "/lists/#{channel}/#{event}", data: message, ext: { auth_token: FAYE_TOKEN } }
    uri = URI.parse "http://#{request.host}:9292/faye" 
    Net::HTTP.post_form uri, :message => message.to_json
  end
    
end

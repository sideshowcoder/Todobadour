module ApplicationHelper
  # Load Facebook Share
  include FacebookShare
  
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
    uri = URI.parse "http://#{host}:9292/faye" 
    Net::HTTP.post_form uri, :message => message.to_json
  end
  
  def host
    request.host.dup.force_encoding(Encoding::UTF_8)
  end
    
end

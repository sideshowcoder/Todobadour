module ApplicationHelper
  
  # Make the title configurable and available everywhere
  def title
    base_name = "Todobadour"
    @title.nil? ? base_name : "#{base_name} : #{@title}"
  end
  
  # Broadcast a message via Faye
  def publish(channel, &block)
    broadcast channel, capture(&block)
  end
  
  def broadcast channel, message 
    message = {:channel => channel, :data => message, :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse("http://#{request.host}:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)      
  end
  
  
end

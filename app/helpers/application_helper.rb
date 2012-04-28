module ApplicationHelper
  
  # Make the title configurable and available everywhere
  def title
    base_name = "Todobadour"
    @title.nil? ? base_name : "#{base_name} : #{@title}"
  end
  
  # Broadcast a message via Faye
  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse("http://#{request.host}:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
  
end

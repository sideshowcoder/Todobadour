require "net/http"

class FayeMessage

  attr_reader :config

  def initialize
    config_path = File.join(File.dirname(__FILE__), "..", "..", "config", "faye.yml")
    @config = YAML.load_file(config_path)[Rails.env].symbolize_keys!
  end

  def publish(event, channel, message)
    message = { channel: "/#{channel}/#{event}", data: message, ext: { auth_token: config[:token] } }
    p message
    Net::HTTP.post_form(faye_uri, message: message.to_json)    
  end

  def faye_js_url
    "#{faye_host}/faye.js"
  end

  def faye_server
    "#{faye_host}/faye"
  end

  private 
  def faye_uri
    URI.parse("#{faye_server}")
  end

  def faye_host
    "http://#{config[:host]}:#{config[:port]}"
  end


end

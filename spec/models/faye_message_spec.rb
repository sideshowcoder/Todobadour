require "spec_helper"

describe FayeMessage do

  it "should have a config" do
    subject.config.should_not be_nil
  end

  it "should publish a message" do
    response = subject.publish("foo", "bar", "baz")
    response.code.should == "200"
  end

  it "should set the faye js include url" do
    subject.faye_js_url.should == "http://localhost:9292/faye.js"
  end

  it "should set the faye server" do
    subject.faye_server.should == "http://localhost:9292/faye"
  end

end

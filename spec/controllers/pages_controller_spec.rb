require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
    it "should have the title about" do
      get 'about'
      response.should have_selector "title", :content => "Todobadour : About"
    end
  end
  
  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    it "should have the title about" do
      get 'home'
      response.should have_selector "title", :content => "Todobadour"
    end
  end
  

end

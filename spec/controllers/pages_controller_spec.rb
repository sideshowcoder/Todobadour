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
    before(:each) do
      @list = FactoryGirl.create :list
      request.cookies[:last_list] = @list.slug
    end
    
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    it "should have the title about" do
      get 'home'
      response.should have_selector "title", :content => "Todobadour"
    end
    it "should display the last list if set" do
      get "home"
      response.should have_selector "div", :content => "Go back to #{@list.title}"
    end
    it "should display no list if last list not found" do
      request.cookies[:last_list] = "foobar"
      get "home"
    end
  end
  

end

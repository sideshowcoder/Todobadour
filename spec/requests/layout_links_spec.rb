require 'spec_helper'

describe "LayoutLinks" do
  
  it "should have a home page at '/'" do
    get "/"
    response.should have_selector "title", :content => "Todobadour"
  end
  
  it "should have an about page at '/about'" do
    get "/about"
    response.should have_selector "title", :content => "Todobadour : About"
  end
  
  it "should have working links" do
    visit root_path
    click_link "About"
    response.should have_selector "title", :content => "Todobadour : About"
    click_link "Todobadour"
    response.should have_selector "title", :content => "Todobadour"
  end
  
end

require 'spec_helper'

describe List do
  
  before(:each) do
    @attr = { :title => "Shopping for BBQ", 
              :description => "Get everything for out great BBQ tonight", 
              :slug => "bbq" }
  end
  
  it "should create a list with the given attributes" do
    List.create!(@attr)
  end
  
  it "should require a title"
  
  it "should have a slug present after creation"

end

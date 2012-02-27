require 'spec_helper'

describe List do
  
  before(:each) do
    @attr = { :title => "Shopping for BBQ", 
              :description => "Get everything for out great BBQ tonight", 
              :slug => "bbq" }
  end
  
  it "should create a list with the given attributes" do
    List.create! @attr
  end
  
  it "should require a title" do
    no_title_list = List.new @attr.merge :title => ""
    no_title_list.should_not be_valid
  end
  
  it "title should not be to long" do
    too_long_title_list = List.new @attr.merge :title => "a" * 150
    too_long_title_list.should_not be_valid
  end
  
  it "should require a slug" do
    no_slug_list = List.new @attr.merge :slug => ""
    no_slug_list.should_not be_valid    
  end
  
  it "should have a unique slug" do
    List.create!(@attr)
    duplicate_slug_list = List.new @attr
    duplicate_slug_list.should_not be_valid
  end

end

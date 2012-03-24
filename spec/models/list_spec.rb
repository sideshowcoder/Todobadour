require 'spec_helper'

describe List do
  
  before(:each) do
    slug = "bbq-#{rand 36**8}"
    @attr = { :title => "Shopping for BBQ", 
              :description => "Get everything for out great BBQ tonight", 
              :slug => slug }
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
    
  it "should have a unique slug" do
    List.create! @attr
    duplicate_slug_list = List.new @attr
    duplicate_slug_list.should_not be_valid
  end
  
  it "should generate a slug on save if none is present" do
    list = List.create! @attr.merge :slug => ""    
    list.slug.should_not be_blank
    list = List.create!({ :title => "just a title" })
    list.slug.should_not be_blank
  end
  
  describe "todo association" do
    
    before :each do
      @list = Factory :list
      @tdone = Factory :todo, :list => @list, :done => true, :created_at => 2.day.ago
      @t1 = Factory :todo, :list => @list, :created_at => 1.day.ago
      @t2 = Factory :todo, :list => @list, :created_at => 1.hour.ago
    end
    
    it "should return the todos in with done todos being last" do
      @list.todos.should == [@t1, @t2, @tdone]
    end
    
    it "should destroy associated todos" do
      @list.destroy
      [@t1, @t2].each do
        lambda do
          Todo.find @t1 
        end.should raise_error ActiveRecord::RecordNotFound
      end
    end
    
  end

end

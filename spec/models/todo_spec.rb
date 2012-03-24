require 'spec_helper'

describe Todo do

  before :each do
    @list = Factory :list
    @attr = {
      :title => "buy bbq sauce",
      :done => false,
    }
  end
  
  it "should create a create a new instance with valid attributes" do
    @list.todos.create! @attr
  end
  
  describe "validations" do
    
    it "should require a list id" do
      Todo.new(@attr).should_not be_valid
    end

    it "should require a nonblank title" do
      @list.todos.build( :title => " " ).should_not be_valid
    end

    it "should reject a to long title" do
      @list.todos.build( :title => "a" * 141 ).should_not be_valid      
    end
    
  end
  
  describe "defaults" do
    
    it "should default done to false" do
      t = @list.todos.create! :title => "Meat"
      t.done == false
    end

    it "should allow done to true" do
      t = @list.todos.create! :title => "Meat", :done => true
      t.done == true
    end
    
  end
  
  describe "list association" do
    
    before :each do
      @todo = @list.todos.create! @attr
    end
    
    it "should have a list attribute" do
      @todo.should respond_to :list
    end
    
    it "should have the right list associated" do
      @todo.list_id.should == @list.id
      @todo.list.should == @list
    end
    
  end

end

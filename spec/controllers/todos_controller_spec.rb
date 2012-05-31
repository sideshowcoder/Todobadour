require 'spec_helper'

describe TodosController do
  render_views
    
  describe "POST 'create'" do

    before(:each) do
      @list = FactoryGirl.create :list
      @attr = { :title => "Bug Sauce" }
    end
    
    describe "failure" do
      
      it "should not create a todo" do
        lambda do
          post :create, :list_id => @list, :todo => { :title => "" }
        end.should_not change Todo, :count
      end
      
      it "should render the list page" do
        post :create, :list_id => @list, :todo => { :title => "" }
        response.should redirect_to @list
      end

    end
    
    describe "success" do

      it "should create a todo" do
        lambda do
          post :create, :list_id => @list, :todo => @attr
        end.should change(Todo, :count).by 1
      end
      
      it "should render the list page" do
        post :create, :list_id => @list, :todo => @attr
        response.should redirect_to @list
      end

    end
    
  end
  
  # FIXME this is not working since faye is not responding!
  describe "PUT 'update'" do
  
    before(:each) do
      @list = FactoryGirl.create :list
      @todo = FactoryGirl.create :todo, :list => @list
      @attr = { :title => "Bug Sauce" }
    end
    
    describe "failure" do
      
      it "should not update a todo" do
        put :update, :list_id => @list, :id => @todo,  :todo => { :title => "" }
        Todo.find(@todo).title.should_not == ""
      end
      
      it "should render the list page" do
        put :update, :list_id => @list, :id => @todo,  :todo => { :title => "" }
        response.should redirect_to @list
      end
  
    end
    
    describe "success" do
  
      it "should create a todo" do
        put :update, :list_id => @list, :id => @todo,  :todo => @attr
        Todo.find(@todo).title.should == @attr[:title]
      end
      
      it "should render the list page" do
        put :update, :list_id => @list, :id => @todo,  :todo => @attr
        response.should redirect_to @list
      end
  
    end
    
  end
  
  describe "Delete 'destroy'" do
    
    before(:each) do
      @list = FactoryGirl.create :list
      @todo = FactoryGirl.create :todo, :list => @list
    end
    
    it "should delete a todo" do
      lambda do
        delete :destroy, :list_id => @list, :id => @todo
       end.should change(Todo, :count).by(-1)
    end
        
    it "should redirect to the list page" do
      delete :destroy, :list_id => @list, :id => @todo
      response.should redirect_to @list
    end
    
  end
  
  
  
end

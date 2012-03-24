require 'spec_helper'

describe TodosController do
  render_views
  
  describe "GET 'show'" do
    
    before(:each) do
      @list = Factory :list
      @todo = Factory :todo, :list => @list 
    end
    
    it "should show a single todo" do
      get :show, :list_id => @list, :id => @todo
      response.should have_selector "span.title", :content => @todo.title
    end
    
  end
  
  describe "POST 'create'" do

    before(:each) do
      @list = Factory :list
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
  
end

require 'spec_helper'

describe ListsController do
  render_views
  
  describe "POST 'create'" do
    
    before(:each) do
      @attr =  { :title => "Shopping for BBQ", 
                :description => "Get everything for out great BBQ tonight" }
    end
    
    it "should create a list" do
      lambda do
        post :create, :list => @attr
      end.should change(List, :count).by(1)
    end
    
    it "should redirect to the list page" do
      post :create, :list => @attr
      response.should redirect_to list_path assigns :list 
    end
    
  end
  
  describe "PUT 'update'" do
    
    before(:each) do
      @list = Factory :list
      @attr = { :title => "Changed #{@list.title}",
                :description => "Changed #{@list.description}" }
    end
    
    it "should update title list" do
      put :update, :id => @list, :list => @attr
      List.find(@list).title.should == @attr[:title]
    end
        
    it "should redirect to the list page" do
      put :update, :id => @list, :list => @attr
      response.should redirect_to @list
    end
    
  end

  describe "Delete 'destroy'" do
    
    before(:each) do
      @list = Factory :list
    end
    
    it "should delete a list" do
      lambda do
        delete :destroy, :id => @list
       end.should change(List, :count).by(-1)
    end
        
    it "should redirect to the list page" do
      delete :destroy, :id => @list
      response.should redirect_to root_path
    end
    
  end
  
  
  describe "GET 'show'" do

    before(:each) do
      @list = List.create! :title => "Shopping for BBQ", 
    end
    
    it "should show the lists todos" do
      @t1 = Factory :todo, :list => @list, :title => "buy milk"
      @t2 = Factory :todo, :list => @list, :title => "buy bread", :done => true
      get :show, :id => @list
      response.should have_selector "span.title", :content => @t1.title
      response.should have_selector "span.title", :content => @t2.title
      response.should have_selector "li.done"
    end

  end
end

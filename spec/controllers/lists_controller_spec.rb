require 'spec_helper'

describe ListsController do
  
  describe "PUT 'update'" do
    
    before(:each) do
      @list = FactoryGirl.create :list
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
      @list = FactoryGirl.create :list
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
      @list = List.create! :title => "Shopping for BBQ"
    end
    
    it "should set a cookie" do
      get :show, :id => @list
      response.cookies['last_list'].should eq(@list.slug)
    end

    it "sets the cookie expiration" do
      stub_cookie_jar = HashWithIndifferentAccess.new
      controller.stub(:cookies) { stub_cookie_jar }
      get :show, :id => @list
      last_list_cookie = stub_cookie_jar['last_list']
      last_list_cookie[:expires].to_i.should be_within(1).of(14.day.from_now.to_i)
    end
    
  end
    
end

require 'spec_helper'

describe ListsController do
  render_views
  
  describe "POST 'create'" do
    
    before(:each) do
      @attr =  { :title => "Shopping for BBQ", 
                :description => "Get everything for out great BBQ tonight", 
                :slug => "bbq" }
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

end

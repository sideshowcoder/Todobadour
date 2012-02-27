class ListsController < ApplicationController
  
  def show
    @list = List.find params[:id]
  end
  
  def create
  end
  
  def destroy
  end
  
  
end

class ListsController < ApplicationController
  
  def show
    @list = List.find params[:id]
  end
  
  def create
    @list = List.new params[:list]
    if @list.save
      redirect_to @list
    else
      # If creation fails redirect home... and display error
      redirect_to root_path
    end
  end
  
  def destroy
  end
  
  
end

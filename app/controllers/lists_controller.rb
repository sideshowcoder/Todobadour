class ListsController < ApplicationController
  
  def show
    @list = List.find params[:id]
    @todo = Todo.new
  end
  
  def create
    @list = List.new params[:list]
    if @list.save! params[:list]
      redirect_to @list
    else
      # If creation fails redirect home... and display error
      redirect_to root_path
    end
  end
  
  def destroy
    List.find(params[:id]).destroy
    redirect_to root_path
  end
  
  def update
    @list = List.find params[:id]
    @list.update_attributes params[:list]
    redirect_to @list
  end
  
end

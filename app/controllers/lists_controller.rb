class ListsController < ApplicationController
  respond_to :html, :json  
    
  def show
    @list = List.find params[:id]
    @todo = Todo.new
    # Save list to cookie
    cookies[:last_list] = { :value => @list.slug, :expires => 14.day.from_now }
  end
  
  def create
    @list = List.new params[:list]
    if @list.save! params[:list]
      respond_with @list
    else
      redirect_to root_path
    end
  end
  
  def destroy
    List.find(params[:id]).destroy
    # Remove the cookie if the list is destoried!
    cookies.delete :last_list
    redirect_to root_path
  end
  
  def update
    @list = List.find params[:id]
    @list.update_attributes params[:list]
    respond_with(@list) do |format|
      format.html { render @list }
      format.json { respond_with_bip @list }
    end
  end
  
end

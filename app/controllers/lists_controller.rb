class ListsController < ApplicationController
  respond_to :html, :json, :js
    
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
    list = params[:list]
    
    # Save ranking
    if list[:todos]
      @list.todos.each do |todo|
        todo.position = list[:todos].index("todo_#{todo.id}")
        todo.save
      end
      list.delete(:todos)
    end
    
    # save other updates
    @list.update_attributes list
    respond_with(@list) do |format|
      format.js
      format.html { render @list }
      format.json { respond_with_bip @list }
    end
  end
  
  def email
    @list = List.find params[:id]

    receiver = params[:receiver]
    sender = params[:sender]
    
    @list.share_via_email sender, receiver
    
    respond_with(@list) do |format|
      format.js
      format.json { true.to_json }
      format.html { render @list }
    end
    
  end
      
end

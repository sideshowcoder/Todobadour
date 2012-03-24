class TodosController < ApplicationController
  respond_to :html, :json    
  
  def show
    @list = current_list
    @todo = Todo.find params[:id]
  end
  
  def create
    @todo = current_list.todos.build params[:todo]
    if @todo.save
      flash[:success] = "Todo created"
    end
    redirect_to current_list      
  end
  
  def destroy
    Todo.find(params[:id]).destroy
    redirect_to current_list
  end
  
  def update
    @todo = Todo.find params[:id]
    @todo.update_attributes params[:todo]
    respond_with(@todo) do |format|
      format.html { redirect_to current_list }
      format.json { render :json => @todo }
      format.xml  { render :xml  => @todo }
    end
  end
  
  private
    def current_list
      List.find params[:list_id]
    end
  
end

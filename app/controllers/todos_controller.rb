class TodosController < ApplicationController
  
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

  end
  
  def update
    
  end
  
  private
    def current_list
      List.find params[:list_id]
    end
  
end

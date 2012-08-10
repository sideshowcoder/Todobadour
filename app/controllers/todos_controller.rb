class TodosController < ApplicationController
  respond_to :html, :js, :json
    
  include ApplicationHelper
    
  def create
    @list = current_list
    @todo = @list.todos.build params[:todo]
    @todo.position = RankedModel::MIN_RANK_VALUE
    respond_to do |format|
      if @todo.save
        format.js
        format.html { redirect_to current_list }
      else
        format.js { render :partial => "shared/error_messages", :locals => { :object => @todo } }
        format.html { redirect_to current_list }
      end
    end
  end
  
  def destroy
    @removeId = params[:id]
    Todo.find(@removeId).destroy
    @list = current_list
    respond_with() do |format|
      format.js
      format.html { redirect_to current_list }
    end
  end
  
  def update
    @todo = Todo.find params[:id]
    @todo.update_attributes params[:todo]
    
    broadcast current_list.slug, "update", @todo.to_json
    
    respond_with(@todo) do |format|
      format.html { redirect_to current_list }
      format.json { respond_with_bip @todo }
    end
  end
  
  private
    
    def current_list
      List.find params[:list_id]
    end
    
    def todo_list todo
      List.find todo.list_id
    end
          
end

class TodosController < ApplicationController
  respond_to :html, :js, :json

  def create
    @list = current_list
    @todo = @list.todos.build(todo_params)
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
    respond_to do |format|
      if @todo.update_attributes(todo_params)
        FayeMessage.new.publish("update", current_list.slug, @todo.to_json)
        format.html { redirect_to current_list }
        format.json { respond_with_bip @todo }
      else
        format.html { redirect_to current_list }
        format.json { render :json => @todo.errors.full_messages, :status => :unprocessable_entity }
      end
    end
  end

  private
  def todo_params
    params.require(:todo).permit(:title, :done, :position, :list_id, :id)
  end

  def current_list
    List.by_slug params[:list_id]
  end

  def todo_list todo
    List.by_slug todo.list_id
  end

end

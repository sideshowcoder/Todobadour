class ListsController < ApplicationController
  respond_to :html, :json, :js

  def show
    @list = List.for_slug(params[:id])
    @todo = Todo.new
    # Save list to cookie
    cookies[:last_list] = { :value => @list.slug, :expires => 14.day.from_now }
  end

  def create
    @list = List.new params[:list]
    respond_to do |format|
      if @list.save
        format.js { render js: "window.location.href = ('#{list_path(@list)}');" }
        format.html { redirect_to @list }
      else
        format.js { render partial: "shared/error_messages", locals: { object: @list } }
        format.html { redirect_to root_path }
      end
    end
  end

  def destroy
    List.for_slug(params[:id]).destroy
    # Remove the cookie if the list is destoried!
    cookies.delete :last_list
    redirect_to root_path
  end

  def update
    @list = List.for_slug(params[:id])
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
    respond_to do |format|
      if @list.update_attributes list
        format.html { redirect_to @list }
        format.json { respond_with_bip @list }
      else
        format.html { redirect_to @list, notice: "update list failed" }
        format.json { render json: @list.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def email
    @list = List.for_slug(params[:id])

    receiver = params[:receiver]
    sender = params[:sender]
    message = params[:message]

    @list.share_via_email sender, receiver, message

    respond_with(@list) do |format|
      format.js
      format.json { true.to_json }
      format.html { render @list }
    end

  end

end

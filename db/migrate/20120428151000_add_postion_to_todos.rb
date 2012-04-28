class AddPostionToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :position, :integer

  end
end

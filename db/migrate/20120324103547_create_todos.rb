class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.boolean :done
      t.integer :list_id

      t.timestamps
    end
    add_index :todos, :list_id
  end
end

class AddListSlugUniquenessIndex < ActiveRecord::Migration
  def up
    add_index :lists, :slug, :unique => true
  end

  def down
    remove_index :lists, :slug
  end
end

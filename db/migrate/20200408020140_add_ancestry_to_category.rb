class AddAncestryToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :category, :ancestry, :string
    add_index :category, :ancestry
  end
end

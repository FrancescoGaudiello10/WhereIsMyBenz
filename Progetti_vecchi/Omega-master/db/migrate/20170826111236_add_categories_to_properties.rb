class AddCategoriesToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :categories, :string
  end
end

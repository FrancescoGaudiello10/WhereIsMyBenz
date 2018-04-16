class RenamePropertiesColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :properties, :titolo, :title
    rename_column :properties, :descrizione, :description
    rename_column :properties, :prezzo, :price
  end
end

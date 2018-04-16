class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :titolo
      t.text :descrizione
      t.float :prezzo

      t.timestamps
    end
  end
end

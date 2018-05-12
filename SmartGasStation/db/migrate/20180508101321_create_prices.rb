class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.integer :idImpianto
      t.string :descCarburante
      t.float :prezzo
      t.boolean :isSelf
      t.string :dtComu

      t.timestamps
    end
  end
end

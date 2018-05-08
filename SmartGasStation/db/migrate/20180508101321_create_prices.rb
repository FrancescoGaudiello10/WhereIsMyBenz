class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.string :idImpianto
      t.string :descCarburante
      t.string :prezzo
      t.boolean :isSelf
      t.string :dtComu

      t.timestamps
    end
  end
end

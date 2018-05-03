# stazioni di rifornimento aggiunte dal gestore
class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.string :Bandiera
      t.string :Nome
      t.string :Indirizzo

      t.float :Benzina
      t.float :Diesel
      t.float :Super
      t.float :Excellium
      t.float :Metano
      t.float :GPL

      t.boolean :allDay
      t.boolean :Self
      t.boolean :autoLavaggio

      t.timestamps
    end
  end
end


class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.string :Bandiera
      t.string :Nome
      t.string :Indirizzo
      t.string :Comune
      t.string :Provincia

      t.timestamps
    end
  end
end

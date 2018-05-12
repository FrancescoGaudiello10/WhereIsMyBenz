class CreateImplants < ActiveRecord::Migration[5.2]
  def change
    create_table :implants do |t|
      t.integer :idImpianto
      t.string :Gestore
      t.string :Bandiera
      t.string :TipoImpianto
      t.string :NomeImpianto
      t.string :Indirizzo
      t.string :Comune
      t.string :Provincia
      t.float :latitude
      t.float :longitude
      t.float :distance

      t.timestamps
    end
  end
end

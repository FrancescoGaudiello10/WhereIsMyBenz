class CreateImplants < ActiveRecord::Migration[5.2]
  def change
    create_table "implants", primary_key: "idImpianto", id: :text, force: :cascade do |t|
      t.text "Gestore"
      t.text "Bandiera"
      t.text "TipoImpianto"
      t.text "NomeImpianto"
      t.text "Indirizzo"
      t.text "Comune"
      t.text "Provincia"
      t.float "latitude"
      t.float "longitude"
      t.timestamps
    
    end
  end
end

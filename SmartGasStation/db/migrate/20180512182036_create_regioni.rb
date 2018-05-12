class CreateRegioni < ActiveRecord::Migration[5.2]
  def change
    create_table :regioni do |t|
      t.string :regione
      t.string :sigla
      t.string :provincia

      t.timestamps
    end
  end
end

class AddPropertyRefToPrenotations < ActiveRecord::Migration[5.1]
  def change
    add_reference :prenotations, :property, foreign_key: true
  end
end

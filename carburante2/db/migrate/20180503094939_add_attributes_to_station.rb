class AddAttributesToStation < ActiveRecord::Migration[5.2]
  def change
    add_column :stations, :Benzina, :float
    add_column :stations, :Diesel, :float
    add_column :stations, :Super, :float
    add_column :stations, :Excellium, :float
    add_column :stations, :Metano, :float
    add_column :stations, :GPL, :float
    add_column :stations, :allDay, :boolean
    add_column :stations, :Self, :boolean
    add_column :stations, :autoLavaggio, :boolean
  end
end

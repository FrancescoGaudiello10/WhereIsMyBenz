class AddLongitudeToProperty < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :longitude, :float
  end
end

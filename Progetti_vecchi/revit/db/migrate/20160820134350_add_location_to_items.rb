class AddLocationToItems < ActiveRecord::Migration
  def change
    add_column :items, :store_location, :string
    add_column :items, :latitude, :float
    add_column :items, :longitude, :float
  end
end

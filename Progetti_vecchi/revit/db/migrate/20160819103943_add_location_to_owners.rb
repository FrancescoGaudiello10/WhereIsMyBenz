class AddLocationToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :address, :string
    add_column :owners, :latitude, :float
    add_column :owners, :longitude, :float
  end
end

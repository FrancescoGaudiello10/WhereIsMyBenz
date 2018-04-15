class AddOfferToProperty < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :offer, :float
  end
end

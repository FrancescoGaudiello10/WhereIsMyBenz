class AddCityToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :city, :string
  end
end

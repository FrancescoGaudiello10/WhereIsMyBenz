class CreateFavouritersAndFavourites < ActiveRecord::Migration[5.1]
  def change
    create_table :favouriters_and_favourites, id:false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :property, index: true
    end
  end
end

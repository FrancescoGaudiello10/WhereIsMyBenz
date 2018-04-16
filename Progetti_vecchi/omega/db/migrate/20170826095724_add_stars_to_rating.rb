class AddStarsToRating < ActiveRecord::Migration[5.1]
  def change
    add_column :ratings, :stars, :Integer
  end
end

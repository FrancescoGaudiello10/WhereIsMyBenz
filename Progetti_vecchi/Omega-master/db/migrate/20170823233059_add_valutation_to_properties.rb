class AddValutationToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :valutation, :integer
  end
end

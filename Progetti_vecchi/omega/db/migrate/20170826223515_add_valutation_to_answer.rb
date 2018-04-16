class AddValutationToAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :valutation, :integer
  end
end

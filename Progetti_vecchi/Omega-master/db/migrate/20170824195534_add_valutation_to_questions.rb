class AddValutationToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :valutation, :integer
  end
end

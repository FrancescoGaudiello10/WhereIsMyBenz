class CreateAnswerRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :answer_ratings do |t|
      t.references :user, foreign_key: true
      t.references :answer, foreign_key: true
      t.integer :stars

      t.timestamps
    end
  end
end

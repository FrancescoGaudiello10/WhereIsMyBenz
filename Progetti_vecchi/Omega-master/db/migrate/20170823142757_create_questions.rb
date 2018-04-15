class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :body
      t.references :user, foreign_key: true
      t.references :property, foreign_key: true

      t.timestamps
    end
  end
end

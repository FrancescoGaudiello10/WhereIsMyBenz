class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :value
      t.integer :owner_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

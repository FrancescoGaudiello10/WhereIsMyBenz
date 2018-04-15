class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :value
      t.integer :evaluated_id
      t.integer :evaluater_id

      t.timestamps null: false
    end
  end
end

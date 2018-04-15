class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :reported_id
      t.integer :reporter_id


      t.timestamps null: false
    end
  end
end

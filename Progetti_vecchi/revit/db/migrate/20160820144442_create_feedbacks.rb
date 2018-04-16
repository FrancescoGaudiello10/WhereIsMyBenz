class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.boolean :value
      t.integer :receiver_id
      t.integer :giver_id
      t.timestamps null: false
    end
  end
end

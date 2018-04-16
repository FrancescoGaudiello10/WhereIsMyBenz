class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.belongs_to :ad, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end

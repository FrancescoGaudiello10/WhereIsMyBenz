class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.text :description
      t.string :genre
      t.string :pegi
      t.string :year
      t.string :maker
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end

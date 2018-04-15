class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.text :description
      t.string :type
      t.text :location
      t.text :delivery
      t.belongs_to :user, index: true
      t.belongs_to :game, index: true
      t.timestamps null: false
    end
  end
end

class CreateAdds < ActiveRecord::Migration
  def change
    create_table :adds do |t|
      t.string :name
      t.text :description
      t.float :price
      t.references :owner, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :adds, [:owner_id, :created_at]
    

  end
end

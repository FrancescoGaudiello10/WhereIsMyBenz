class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.text :description
      t.belongs_to :reportable, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end

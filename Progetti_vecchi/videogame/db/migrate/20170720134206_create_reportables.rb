class CreateReportables < ActiveRecord::Migration
  def change
    create_table :reportables do |t|

      t.timestamps null: false
    end
  end
end

class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
        t.integer 'potatoes'
        t.text 'comment'
        t.references :user
        t.references :movie
    end
  end
end

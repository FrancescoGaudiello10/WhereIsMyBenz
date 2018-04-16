class AddDataToReviews < ActiveRecord::Migration
  def change
    #add_column :reviews, :created_at, :datetime
    add_column :reviews, :update_at, :datetime
  end
end

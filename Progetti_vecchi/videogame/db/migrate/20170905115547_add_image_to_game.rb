class AddImageToGame < ActiveRecord::Migration
  def change
    add_attachment :games, :image
  end
end

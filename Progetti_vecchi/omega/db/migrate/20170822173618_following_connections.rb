class FollowingConnections < ActiveRecord::Migration[5.1]
  def change
    create_table "following_connections", :force => true, :id => false do |t|
      t.integer "follower_id", :null => false
      t.integer "following_id", :null => false
    end
  end
end
